import chisel3._
import chisel3.util._

class ChiselTop() extends Module {
  val io = IO(new Bundle {
    val ui_in = Input(UInt(8.W))      // Dedicated inputs
    val uo_out = Output(UInt(8.W))    // Dedicated outputs
    val uio_in = Input(UInt(8.W))     // IOs: Input path
    val uio_out = Output(UInt(8.W))   // IOs: Output path
    val uio_oe = Output(UInt(8.W))    // IOs: Enable path (active high: 0=input, 1=output)
  })

  // drive bi-directionals outputs path to zero
  io.uio_out := 0.U
  // use bi-directionals as input
  io.uio_oe := 0.U

  val redOut = WireDefault(0.U(2.W))
  val greenOut = WireDefault(0.U(2.W))
  val blueOut = WireDefault(0.U(2.W))
  val vSyncOut = WireDefault(false.B)
  val hSyncOut = WireDefault(false.B)

  //Mapping of renamed output
  //uo_out[0] - R1
  //uo_out[1] - G1
  //uo_out[2] - B1
  //uo_out[3] - vsync
  //uo_out[4] - R0
  //uo_out[5] - G0
  //uo_out[6] - B0
  //uo_out[7] - hsync
  //io.uo_out(0) := RedOut(1) //- R0
  //io.uo_out(1) := GreenOut(1) //- G1
  //io.uo_out(2) := BlueOut(1) //- B1
  //io.uo_out(3) := VsyncOut //- vsync
  //io.uo_out(4) := RedOut(0) //- R0
  //io.uo_out(5) := GreenOut(0) //- G0
  //io.uo_out(6) := BlueOut(0) //- B0
  //io.uo_out(7) := HsyncOut //- hsync

  io.uo_out := hSyncOut ## blueOut(0) ## greenOut(0) ## redOut(0) ## vSyncOut ## blueOut(1) ## greenOut(1) ## redOut(1) //- R0

  // Inputs definitiona
  //io.ui_in(1) ## io.ui_in(0) // Select of the time clock source (switches)
                               // 00: internal 25MHz
                               // 01: internal 25.175 MHz
                               // 10: external 32768Hz
                               // 11: external 1 Hz
  //io.ui_in(2) // Input with 1Hz frequency
  //io.ui_in(3) // Input with 32768Hz frequency
  //io.ui_in(4) // Increase hours (button)
  //io.ui_in(5) // Decrease hours (button)
  //io.ui_in(6) // Select to increase hours (1) or minutes (0) (switch)
  //io.ui_in(7) // Clear seconds

  // Synchronizers
  val tClkSelectInBounce = RegPipeline(VecInit(io.ui_in(0), io.ui_in(1)).asUInt, 2, 0.U(2.W))
  val tClk1HzIn = RegPipeline(io.ui_in(2), 2, false.B)
  val tClk32kHzIn = RegPipeline(io.ui_in(3), 2, false.B)
  val plusInBounce = RegPipeline(io.ui_in(4), 2, false.B)
  val minusInBounce = RegPipeline(io.ui_in(5), 2, false.B)
  val hourMinuteSetSelInBounce = RegPipeline(io.ui_in(6), 2, false.B)
  val secondsClearInBounce = RegPipeline(io.ui_in(7), 2, false.B)

  // De-bouncers
  val CLOCK_FREQUENCY_HZ = 25000000 //25 MHz (for devouncing, still OK if 25.175)
  val DEBOUNCE_PERIOD_US = 22000 //22 ms
  val DEBOUNCE_COUNTER_MAX = CLOCK_FREQUENCY_HZ / 1000000 * DEBOUNCE_PERIOD_US
  val debounceCounter = RegInit(0.U(log2Up(DEBOUNCE_COUNTER_MAX).W))
  val debounceSampleEn = WireDefault(false.B)
  when(debounceCounter === (DEBOUNCE_COUNTER_MAX - 1).U) {
    debounceCounter := 0.U
    debounceSampleEn := true.B
  }.otherwise {
    debounceCounter := debounceCounter + 1.U
    debounceSampleEn := false.B
  }

  val tClkSelectIn = RegEnable(tClkSelectInBounce, 0.U(2.W), debounceSampleEn)
  val plusIn = RegEnable(plusInBounce, false.B, debounceSampleEn)
  val minusIn = RegEnable(minusInBounce, false.B, debounceSampleEn)
  val hourMinuteSetSelIn = RegEnable(hourMinuteSetSelInBounce, false.B, debounceSampleEn)
  val secondsClearIn = RegEnable(secondsClearInBounce, false.B, debounceSampleEn)

  ////////////////////////////////////
  //VGA CONTROLLER
  ////////////////////////////////////

  //VGA parameters
  val VGA_H_DISPLAY_SIZE = 640
  val VGA_V_DISPLAY_SIZE = 480
  val VGA_H_FRONT_PORCH_SIZE = 16
  val VGA_H_SYNC_PULSE_SIZE = 96
  val VGA_H_BACK_PORCH_SIZE = 48
  val VGA_V_FRONT_PORCH_SIZE = 10
  val VGA_V_SYNC_PULSE_SIZE = 2
  val VGA_V_BACK_PORCH_SIZE = 33

  val counterXReg = RegInit(0.U(10.W))
  val counterYReg = RegInit(0.U(10.W))

  val run = WireDefault(true.B)
  when(run) {
      when(counterXReg === (VGA_H_DISPLAY_SIZE + VGA_H_FRONT_PORCH_SIZE + VGA_H_SYNC_PULSE_SIZE + VGA_H_BACK_PORCH_SIZE - 1).U) { // CounterXMax = 800.U // 640 + 16 +  96 + 48
        counterXReg := 0.U
        when(counterYReg === (VGA_V_DISPLAY_SIZE + VGA_V_FRONT_PORCH_SIZE + VGA_V_SYNC_PULSE_SIZE + VGA_V_BACK_PORCH_SIZE - 1).U) { // CounterYMax = 525.U // 480 + 10 + 2 + 33
          counterYReg := 0.U
        }.otherwise {
          counterYReg := counterYReg + 1.U
        }
      }.otherwise {
        counterXReg := counterXReg + 1.U
      }
  }

  val hSync = (counterXReg >= (VGA_H_DISPLAY_SIZE + VGA_H_FRONT_PORCH_SIZE).U && (counterXReg < (VGA_H_DISPLAY_SIZE + VGA_H_FRONT_PORCH_SIZE + VGA_H_SYNC_PULSE_SIZE).U)) // active for 96 cycles of the CounterX
  val vSync = (counterYReg >= (VGA_V_DISPLAY_SIZE + VGA_V_FRONT_PORCH_SIZE).U && (counterYReg < (VGA_V_DISPLAY_SIZE + VGA_V_FRONT_PORCH_SIZE + VGA_V_SYNC_PULSE_SIZE).U)) // active for 2 cycles of the CounterY
  hSyncOut := RegNext(hSync)
  vSyncOut := RegNext(vSync)

  val inDisplayArea = (counterXReg < VGA_H_DISPLAY_SIZE.U) && (counterYReg < VGA_V_DISPLAY_SIZE.U)
  val pixelX = counterXReg
  val pixelY = counterYReg(8,0)

  val vSyncReg = RegInit(false.B)
  vSyncReg := vSync
  val newFrame = vSync && (!vSyncReg)


  ////////////////////////////////////
  // CLOCK
  ////////////////////////////////////
  //val TClkSelectIn = RegPipeline(io.ui_in(1) ## io.ui_in(0), 3, false.B)
  //val TClk1HzIn = RegPipeline(io.ui_in(2), 3, false.B)
  //val TClk32kHzIn = RegPipeline(io.ui_in(3), 3, false.B)

  val newDay = WireDefault(false.B)

  //Generate control commands
  val plusInReg = RegInit(false.B)
  plusInReg := plusIn
  val plusReqReg = RegInit(false.B)
  val plus = WireDefault(false.B)
  when(plusIn && (!plusInReg)) {
    plusReqReg := true.B
  }.elsewhen(plusReqReg && newFrame) {
    plus := true.B
    plusReqReg := false.B
  }

  val minusInReg = RegInit(false.B)
  minusInReg := minusIn
  val minusReqReg = RegInit(false.B)
  val minus = WireDefault(false.B)
  when(minusIn && (!minusInReg)) {
    minusReqReg := true.B
  }.elsewhen(minusReqReg && newFrame) {
    minus := true.B
    minusReqReg := false.B
  }

  val secondsClearInReg = RegInit(false.B)
  secondsClearInReg := secondsClearIn
  val secondsClearReqReg = RegInit(false.B)
  val secondsClear = WireDefault(false.B)
  when(secondsClearIn && (!secondsClearInReg)) {
    secondsClearReqReg := true.B
  }.elsewhen(secondsClearReqReg && newFrame) {
    secondsClear := true.B
    secondsClearReqReg := false.B
  }

  // Generate 1CC pulse at 1 Hz based on selected source (tClkPulse)
  val tClk1HzInReg = RegInit(false.B)
  tClk1HzInReg := tClk1HzIn
  val tClkPulse1Hz = tClk1HzIn && (!tClk1HzInReg)
  val tClk32kHzInReg = RegInit(false.B)
  tClk32kHzInReg := tClk32kHzIn
  val tClkPulse32kHzEn = tClk32kHzIn && (!tClk32kHzInReg)

  val tClkPulse25MHz = WireDefault(false.B)
  val tClkPulse25MHz175 = WireDefault(false.B)
  val tClkPulse32kHz = WireDefault(false.B)
  val tClkPulse = WireDefault(false.B)

  val cntReg = RegInit(0.U(25.W))
  val cntRegPlusOne = cntReg + 1.U
  switch(tClkSelectIn) {
    is(0.U) {
      // 00: internal 25MHz
      when(cntReg >= (25000000 - 1).U) {
        cntReg := 0.U
        tClkPulse25MHz := true.B
      } .otherwise{
        cntReg := cntRegPlusOne
      }
      tClkPulse := tClkPulse25MHz
    }
    is(1.U) {
      // 01: internal 25.175 MHz
      when(cntReg >= (2500 - 1).U) {//(25175000 - 1).U) {
        cntReg := 0.U
        tClkPulse25MHz175 := true.B
      }.otherwise {
        cntReg := cntRegPlusOne
      }
      tClkPulse := tClkPulse25MHz175
    }
    is(2.U) {
      // 10: external 32768Hz
      when(tClkPulse32kHzEn){
        when(cntReg >= (32768 - 1).U) { //32768
          cntReg := 0.U
          tClkPulse32kHz := true.B
        }.otherwise {
          cntReg := cntRegPlusOne
        }
      }
      tClkPulse := tClkPulse32kHz
    }
    is(3.U) {
      // 11: external 1 Hz
      cntReg := 0.U
      tClkPulse := tClkPulse1Hz
    }
  }

  val tClkReqReg = RegInit(false.B)
  val tClk = WireDefault(false.B)
  when(tClkPulse) {
    tClkReqReg := true.B
  } .elsewhen (tClkReqReg && newFrame){
    tClk := true.B
    tClkReqReg := false.B
  }

  val hourDecReg = RegInit(0.U(2.W)) // 0 - 2
  val hourUniReg = RegInit(0.U(4.W)) // 0 - 9

  val minuteDecReg = RegInit(0.U(3.W)) // 0 - 5
  val minuteUniReg = RegInit(0.U(4.W)) // 0 - 9

  val secondDecReg = RegInit(0.U(3.W)) // 0 - 5
  val secondUniReg = RegInit(0.U(4.W)) // 0 - 9

  when(secondsClear){
    // set seconds
    secondUniReg := 0.U
    secondDecReg := 0.U
  }.elsewhen(plus){
    when(hourMinuteSetSelIn){
      //set hours
      hourUniReg := hourUniReg + 1.U
      when(hourUniReg === 9.U && (hourDecReg === 0.U || hourDecReg === 1.U)) {
        hourUniReg := 0.U
        hourDecReg := hourDecReg + 1.U
      }.elsewhen(hourUniReg === 3.U && hourDecReg === 2.U) {
        hourUniReg := 3.U
        hourDecReg := 2.U
      }
    }.otherwise{
      //set minutes
      minuteUniReg := minuteUniReg + 1.U
      when(minuteUniReg === 9.U && minuteDecReg =/= 5.U) {
        minuteUniReg := 0.U
        minuteDecReg := minuteDecReg + 1.U
      }.elsewhen(minuteUniReg === 9.U && minuteDecReg === 5.U) {
        minuteUniReg := 9.U
        minuteDecReg := 5.U
      }
    }

  }.elsewhen(minus){
    when(hourMinuteSetSelIn) {
      //set hours
      when(hourUniReg === 0.U && hourDecReg === 0.U) {
        hourUniReg := 0.U
        hourDecReg := 0.U
      } .otherwise {
        hourUniReg := hourUniReg - 1.U
        when(hourUniReg === 0.U) {
          hourUniReg := 9.U
          hourDecReg := hourDecReg - 1.U
        }
      }

    }.otherwise {
      //set minutes
      when(minuteUniReg === 0.U && minuteDecReg === 0.U) {
        minuteUniReg := 0.U
        minuteDecReg := 0.U
      }.otherwise {
        minuteUniReg := minuteUniReg - 1.U
        when(minuteUniReg === 0.U) {
          minuteUniReg := 9.U
          minuteDecReg := minuteDecReg - 1.U
        }
      }
    }
  }.elsewhen(tClk) {
    secondUniReg := secondUniReg + 1.U
    //newDay := true.B
    when(secondUniReg === 9.U) {
      secondUniReg := 0.U
      secondDecReg := secondDecReg + 1.U
      when(secondDecReg === 5.U) {
        secondDecReg := 0.U
        minuteUniReg := minuteUniReg + 1.U
        when(minuteUniReg === 9.U) {
          minuteUniReg := 0.U
          minuteDecReg := minuteDecReg + 1.U
          when(minuteDecReg === 5.U) {
            minuteDecReg := 0.U
            hourUniReg := hourUniReg + 1.U
            when(hourUniReg === 9.U && (hourDecReg === 0.U || hourDecReg === 1.U)) {
              hourUniReg := 0.U
              hourDecReg := hourDecReg + 1.U
            }.elsewhen(hourUniReg === 3.U && hourDecReg === 2.U) {
              hourUniReg := 0.U
              hourDecReg := 0.U
              newDay := true.B
            }
          }
        }
      }
    }
  }

  ////////////////////////////////////
  // LFSR - 6-bit Fibonacci modified Linear Feedback Shift Register (LFSR)
  ////////////////////////////////////
  val lfsrReg = RegInit(VecInit(Seq.fill(18)(false.B)))
  val lfsrEn = newDay ||
               lfsrReg.asUInt(5,0) === 0.U ||
               lfsrReg.asUInt(5,0) === 63.U ||
               lfsrReg.asUInt(11,6) === 0.U ||
               lfsrReg.asUInt(11,6) === 63.U ||
               lfsrReg.asUInt(17,12) === 0.U ||
               lfsrReg.asUInt(17,12) === 63.U ||
               lfsrReg.asUInt(5,0) === lfsrReg.asUInt(11,6) ||
               lfsrReg.asUInt(5,0) === lfsrReg.asUInt(17,12) ||
               lfsrReg.asUInt(11,6) === lfsrReg.asUInt(17,12)

  when(lfsrEn){
    for (i <- 1 until 18) {
      lfsrReg(i) := lfsrReg(i - 1)
    }
    when(lfsrReg.asUInt === 0.U) {
      lfsrReg(0) := true.B
    } otherwise{
      lfsrReg(0) := lfsrReg(17) ^ lfsrReg(10)
    }
  }


  ////////////////////////////////////
  // GRAPHIC ENGINE
  ////////////////////////////////////

  val GE_HOUR_DEC_X_MIN = 10
  val GE_HOUR_DEC_X_MAX = 10 + 92
  val GE_HOUR_UNI_X_MIN = 10 + 92 + 8
  val GE_HOUR_UNI_X_MAX = 10 + 92 + 8 + 92
  val GE_MINUTE_DEC_X_MIN = 10 + 92 + 8 + 92 + 16
  val GE_MINUTE_DEC_X_MAX = 10 + 92 + 8 + 92 + 16 + 92
  val GE_MINUTE_UNI_X_MIN = 10 + 92 + 8 + 92 + 16 + 92 + 8
  val GE_MINUTE_UNI_X_MAX = 10 + 92 + 8 + 92 + 16 + 92 + 8 + 92
  val GE_SECOND_DEC_X_MIN = 10 + 92 + 8 + 92 + 16 + 92 + 8 + 92 + 16
  val GE_SECOND_DEC_X_MAX = 10 + 92 + 8 + 92 + 16 + 92 + 8 + 92 + 16 + 92
  val GE_SECOND_UNI_X_MIN = 10 + 92 + 8 + 92 + 16 + 92 + 8 + 92 + 16 + 92 + 8
  val GE_SECOND_UNI_X_MAX = 10 + 92 + 8 + 92 + 16 + 92 + 8 + 92 + 16 + 92 + 8 + 92

  val GE_B3_Y_MIN = 43
  val GE_B3_Y_MAX = 43 + 92
  val GE_B2_Y_MIN = 43 + 92 + 8
  val GE_B2_Y_MAX = 43 + 92 + 8 + 92
  val GE_B1_Y_MIN = 43 + 92 + 8 + 92 + 8
  val GE_B1_Y_MAX = 43 + 92 + 8 + 92 + 8 + 92
  val GE_B0_Y_MIN = 43 + 92 + 8 + 92 + 8 + 92 + 8
  val GE_B0_Y_MAX = 43 + 92 + 8 + 92 + 8 + 92 + 8 + 92

  //val GE_VLINE_H_M_X = 205
  //val GE_VLINE_M_S_X = 405
  //val GE_HLINE_H_M_S_Y = 43 + 92 + 8 + 92 + 8 + 92 + 8 + 92 + 8
  val GE_HLINE_M_S_Y = 43 + 92 + 8 + 92 + 8 + 92 + 8 + 92 + 9
  val GE_HLINE_S_Y = 43 + 92 + 8 + 92 + 8 + 92 + 8 + 92 + 9 + 9


  val inHourDecXArea = pixelX > GE_HOUR_DEC_X_MIN.U && pixelX < GE_HOUR_DEC_X_MAX.U
  val inHourUniXArea = pixelX > GE_HOUR_UNI_X_MIN.U && pixelX < GE_HOUR_UNI_X_MAX.U
  val inMinuteDecXArea = pixelX > GE_MINUTE_DEC_X_MIN.U && pixelX < GE_MINUTE_DEC_X_MAX.U
  val inMinuteUniXArea = pixelX > GE_MINUTE_UNI_X_MIN.U && pixelX < GE_MINUTE_UNI_X_MAX.U
  val inSecondDecXArea = pixelX > GE_SECOND_DEC_X_MIN.U && pixelX < GE_SECOND_DEC_X_MAX.U
  val inSecondUniXArea = pixelX > GE_SECOND_UNI_X_MIN.U && pixelX < GE_SECOND_UNI_X_MAX.U

  val inB3YArea = pixelY > GE_B3_Y_MIN.U && pixelY < GE_B3_Y_MAX.U
  val inB2YArea = pixelY > GE_B2_Y_MIN.U && pixelY < GE_B2_Y_MAX.U
  val inB1YArea = pixelY > GE_B1_Y_MIN.U && pixelY < GE_B1_Y_MAX.U
  val inB0YArea = pixelY > GE_B0_Y_MIN.U && pixelY < GE_B0_Y_MAX.U

  val inXEdge_R3 =
    pixelX === (GE_HOUR_UNI_X_MIN + 1).U || pixelX === (GE_HOUR_UNI_X_MAX - 1).U ||
    pixelX === (GE_MINUTE_UNI_X_MIN + 1).U || pixelX === (GE_MINUTE_UNI_X_MAX - 1).U ||
    pixelX === (GE_SECOND_UNI_X_MIN + 1).U || pixelX === (GE_SECOND_UNI_X_MAX - 1).U

  val inXEdge_R2 =
    pixelX === (GE_MINUTE_DEC_X_MIN + 1).U || pixelX === (GE_MINUTE_DEC_X_MAX - 1).U ||
    pixelX === (GE_SECOND_DEC_X_MIN + 1).U || pixelX === (GE_SECOND_DEC_X_MAX - 1).U ||
    inXEdge_R3

  val inXEdge_R1_R0 =
    pixelX === (GE_HOUR_DEC_X_MIN + 1).U || pixelX === (GE_HOUR_DEC_X_MAX - 1).U ||
    inXEdge_R2

  val inEdgeV =
    (inB3YArea && inXEdge_R3) ||
    (inB2YArea && inXEdge_R2) ||
    ((inB1YArea || inB0YArea) && inXEdge_R1_R0)

  val inYEdge_C5 =
    pixelY === (GE_B1_Y_MIN + 1).U || pixelY === (GE_B1_Y_MAX - 1).U ||
    pixelY === (GE_B0_Y_MIN + 1).U || pixelY === (GE_B0_Y_MAX - 1).U

  val inYEdge_C3_C1 =
    pixelY === (GE_B2_Y_MIN + 1).U || pixelY === (GE_B2_Y_MAX - 1).U ||
    inYEdge_C5

  val inYEdge_C4_C2_C0 =
    pixelY === (GE_B3_Y_MIN + 1).U || pixelY === (GE_B3_Y_MAX - 1).U ||
    inYEdge_C3_C1

  val inEdgeH =
    (inHourDecXArea && inYEdge_C5) ||
    ((inMinuteDecXArea || inSecondDecXArea) && inYEdge_C3_C1) ||
    ((inHourUniXArea || inMinuteUniXArea || inSecondUniXArea) && inYEdge_C4_C2_C0)

  //val inLine = ((pixelY > GE_B3_Y_MIN.U && pixelY < GE_B0_Y_MAX.U) && (pixelX === GE_VLINE_H_M_X.U || pixelX === GE_VLINE_M_S_X.U)) ||
  //             pixelY===GE_HLINE_H_M_S_Y.U && ((pixelX > GE_HOUR_DEC_X_MIN.U && pixelX < GE_HOUR_UNI_X_MAX.U) || (pixelX > GE_MINUTE_DEC_X_MIN.U && pixelX < GE_MINUTE_UNI_X_MAX.U) || (pixelX > GE_SECOND_DEC_X_MIN.U && pixelX < GE_SECOND_UNI_X_MAX.U))

  //val inLineMS = pixelY === GE_HLINE_M_S_Y.U && ((pixelX > GE_HOUR_DEC_X_MIN.U && pixelX < GE_HOUR_UNI_X_MAX.U) || (pixelX > GE_MINUTE_DEC_X_MIN.U && pixelX < GE_MINUTE_UNI_X_MAX.U) || (pixelX > GE_SECOND_DEC_X_MIN.U && pixelX < GE_SECOND_UNI_X_MAX.U))
  val inLineMS = pixelY === GE_HLINE_M_S_Y.U && ((pixelX > GE_MINUTE_DEC_X_MIN.U && pixelX < GE_MINUTE_UNI_X_MAX.U) || (pixelX > GE_SECOND_DEC_X_MIN.U && pixelX < GE_SECOND_UNI_X_MAX.U))
  val inLineS = pixelY === GE_HLINE_S_Y.U && (pixelX > GE_SECOND_DEC_X_MIN.U && pixelX < GE_SECOND_UNI_X_MAX.U)

  val inOuterEdge = pixelX === 0.U || pixelX === 639.U || pixelY === 0.U || pixelY === 479.U


  val GE_DOTS_X = 10 + 92 + 8 + 92 + 16 + 92 + 8 + 92 + 16 + 92 + 8 + 92 + 9

  val GE_DOTS_1_Y_MIN = 43 //+ 0 * 8 + 0 * 4
  val GE_DOTS_1_Y_MAX = 43 + 1 * 8 + 0 * 4
  val GE_DOTS_2_Y_MIN = 43 + 1 * 8 + 1 * 4
  val GE_DOTS_2_Y_MAX = 43 + 2 * 8 + 1 * 4
  val GE_DOTS_3_Y_MIN = 43 + 2 * 8 + 2 * 4
  val GE_DOTS_3_Y_MAX = 43 + 3 * 8 + 2 * 4
  val GE_DOTS_4_Y_MIN = 43 + 3 * 8 + 3 * 4
  val GE_DOTS_4_Y_MAX = 43 + 4 * 8 + 3 * 4
  val GE_DOTS_5_Y_MIN = 43 + 4 * 8 + 4 * 4
  val GE_DOTS_5_Y_MAX = 43 + 5 * 8 + 4 * 4
  val GE_DOTS_6_Y_MIN = 43 + 5 * 8 + 5 * 4
  val GE_DOTS_6_Y_MAX = 43 + 6 * 8 + 5 * 4
  val GE_DOTS_7_Y_MIN = 43 + 6 * 8 + 6 * 4
  val GE_DOTS_7_Y_MAX = 43 + 7 * 8 + 6 * 4
  val GE_DOTS_8_Y_MIN = 43 + 7 * 8 + 7 * 4
  val GE_DOTS_8_Y_MAX = 43 + 92 //+ 8 * 8 + 7 * 4

  val GE_DOTS_9_Y_MIN = 43 + 92 + 8
  val GE_DOTS_9_Y_MAX = 43 + 92 + 8 + 1 * 20 + 0 * 4
  val GE_DOTS_10_Y_MIN = 43 + 92 + 8 + 1 * 20 + 1 * 4
  val GE_DOTS_10_Y_MAX = 43 + 92 + 8 + 2 * 20 + 1 * 4
  val GE_DOTS_11_Y_MIN = 43 + 92 + 8 + 2 * 20 + 2 * 4
  val GE_DOTS_11_Y_MAX = 43 + 92 + 8 + 3 * 20 + 2 * 4
  val GE_DOTS_12_Y_MIN = 43 + 92 + 8 + 3 * 20 + 3 * 4
  val GE_DOTS_12_Y_MAX = 43 + 92 + 8 + 92

  val GE_DOTS_13_Y_MIN = 43 + 92 + 8 + 92 + 8
  val GE_DOTS_13_Y_MAX = 43 + 92 + 8 + 92 + 8 + 48
  val GE_DOTS_14_Y_MIN = 43 + 92 + 8 + 92 + 8 + 48 + 4
  val GE_DOTS_14_Y_MAX = 43 + 92 + 8 + 92 + 8 + 92

  val GE_DOTS_15_Y_MIN = 43 + 92 + 8 + 92 + 8 + 92 + 8
  val GE_DOTS_15_Y_MAX = 43 + 92 + 8 + 92 + 8 + 92 + 8 + 92

  val inDots =
    pixelX === GE_DOTS_X.U &&
    (pixelY > GE_DOTS_1_Y_MIN.U && pixelY < GE_DOTS_1_Y_MAX.U ||
    pixelY > GE_DOTS_2_Y_MIN.U && pixelY < GE_DOTS_2_Y_MAX.U ||
    pixelY > GE_DOTS_3_Y_MIN.U && pixelY < GE_DOTS_3_Y_MAX.U ||
    pixelY > GE_DOTS_4_Y_MIN.U && pixelY < GE_DOTS_4_Y_MAX.U ||
    pixelY > GE_DOTS_5_Y_MIN.U && pixelY < GE_DOTS_5_Y_MAX.U ||
    pixelY > GE_DOTS_6_Y_MIN.U && pixelY < GE_DOTS_6_Y_MAX.U ||
    pixelY > GE_DOTS_7_Y_MIN.U && pixelY < GE_DOTS_7_Y_MAX.U ||
    pixelY > GE_DOTS_8_Y_MIN.U && pixelY < GE_DOTS_8_Y_MAX.U ||
    pixelY > GE_DOTS_9_Y_MIN.U && pixelY < GE_DOTS_9_Y_MAX.U ||
    pixelY > GE_DOTS_10_Y_MIN.U && pixelY < GE_DOTS_10_Y_MAX.U ||
    pixelY > GE_DOTS_11_Y_MIN.U && pixelY < GE_DOTS_11_Y_MAX.U ||
    pixelY > GE_DOTS_12_Y_MIN.U && pixelY < GE_DOTS_12_Y_MAX.U ||
    pixelY > GE_DOTS_13_Y_MIN.U && pixelY < GE_DOTS_13_Y_MAX.U ||
    pixelY > GE_DOTS_14_Y_MIN.U && pixelY < GE_DOTS_14_Y_MAX.U ||
    pixelY > GE_DOTS_15_Y_MIN.U && pixelY < GE_DOTS_15_Y_MAX.U)

  val Red = WireDefault(0.U(2.W))
  val Green = WireDefault(0.U(2.W))
  val Blue = WireDefault(0.U(2.W))

  when(inDisplayArea) {
    when(inEdgeV || inEdgeH || inLineMS || inLineS || inDots || inOuterEdge){
      Red := 3.U
      Green := 3.U
      Blue := 3.U
    } .elsewhen(
      (hourDecReg(1) && inHourDecXArea && inB1YArea) ||
      (hourDecReg(0) && inHourDecXArea && inB0YArea) ||
      (hourUniReg(3) && inHourUniXArea && inB3YArea) ||
      (hourUniReg(2) && inHourUniXArea && inB2YArea) ||
      (hourUniReg(1) && inHourUniXArea && inB1YArea) ||
      (hourUniReg(0) && inHourUniXArea && inB0YArea)
    ) {
      Red := lfsrReg.asUInt(1,0)
      Green := lfsrReg.asUInt(3,2)
      Blue := lfsrReg.asUInt(5,4)
    } .elsewhen(
      (minuteDecReg(2) && inMinuteDecXArea && inB2YArea) ||
      (minuteDecReg(1) && inMinuteDecXArea && inB1YArea) ||
      (minuteDecReg(0) && inMinuteDecXArea && inB0YArea) ||
      (minuteUniReg(3) && inMinuteUniXArea && inB3YArea) ||
      (minuteUniReg(2) && inMinuteUniXArea && inB2YArea) ||
      (minuteUniReg(1) && inMinuteUniXArea && inB1YArea) ||
      (minuteUniReg(0) && inMinuteUniXArea && inB0YArea)
    ) {
      Red := lfsrReg.asUInt(7, 6)
      Green := lfsrReg.asUInt(9, 8)
      Blue := lfsrReg.asUInt(11, 10)
    } .elsewhen(
      (secondDecReg(2) && inSecondDecXArea && inB2YArea) ||
      (secondDecReg(1) && inSecondDecXArea && inB1YArea) ||
      (secondDecReg(0) && inSecondDecXArea && inB0YArea) ||
      (secondUniReg(3) && inSecondUniXArea && inB3YArea) ||
      (secondUniReg(2) && inSecondUniXArea && inB2YArea) ||
      (secondUniReg(1) && inSecondUniXArea && inB1YArea) ||
      (secondUniReg(0) && inSecondUniXArea && inB0YArea)
    ) {
      Red := lfsrReg.asUInt(13, 12)
      Green := lfsrReg.asUInt(15, 14)
      Blue := lfsrReg.asUInt(17, 16)
    }.otherwise {
      Red := 0.U
      Green := 0.U
      Blue := 0.U
    }
  }.otherwise {
    //Out of displayed area --> black
    Red := 0.U
    Green := 0.U
    Blue := 0.U
  }

  redOut := RegNext(Red)
  greenOut := RegNext(Green)
  blueOut := RegNext(Blue)


} //module


object ChiselTop extends App {
  emitVerilog(new ChiselTop(), Array("--target-dir", "src"))
}