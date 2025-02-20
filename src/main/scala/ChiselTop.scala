import chisel3._

/**
 * Example design in Chisel. Luke_1.
 * A redesign of the Tiny Tapeout example.
 */
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

  val RedOut = Wire(UInt(2.W))
  val GreenOut = Wire(UInt(2.W))
  val BlueOut = Wire(UInt(2.W))
  val VsyncOut = Wire(Bool())
  val HsyncOut = Wire(Bool())

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

  io.uo_out := HsyncOut ## BlueOut(0) ## GreenOut(0) ## RedOut(0) ## VsyncOut ## BlueOut(1) ## GreenOut(1) ## RedOut(1) //- R0

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

  val CounterXReg = RegInit(0.U(10.W))
  val CounterYReg = RegInit(0.U(10.W))

  val run = Wire(Bool())
  run := true.B
  when(run) {
      when(CounterXReg === (VGA_H_DISPLAY_SIZE + VGA_H_FRONT_PORCH_SIZE + VGA_H_SYNC_PULSE_SIZE + VGA_H_BACK_PORCH_SIZE - 1).U) { // CounterXMax = 800.U // 640 + 16 +  96 + 48
        CounterXReg := 0.U
        when(CounterYReg === (VGA_V_DISPLAY_SIZE + VGA_V_FRONT_PORCH_SIZE + VGA_V_SYNC_PULSE_SIZE + VGA_V_BACK_PORCH_SIZE - 1).U) { // CounterYMax = 525.U // 480 + 10 + 2 + 33
          CounterYReg := 0.U
        }.otherwise {
          CounterYReg := CounterYReg + 1.U
        }
      }.otherwise {
        CounterXReg := CounterXReg + 1.U
      }
  }

  val Hsync = (CounterXReg >= (VGA_H_DISPLAY_SIZE + VGA_H_FRONT_PORCH_SIZE).U && (CounterXReg < (VGA_H_DISPLAY_SIZE + VGA_H_FRONT_PORCH_SIZE + VGA_H_SYNC_PULSE_SIZE).U)) // active for 96 cycles of the CounterX
  val Vsync = (CounterYReg >= (VGA_V_DISPLAY_SIZE + VGA_V_FRONT_PORCH_SIZE).U && (CounterYReg < (VGA_V_DISPLAY_SIZE + VGA_V_FRONT_PORCH_SIZE + VGA_V_SYNC_PULSE_SIZE).U)) // active for 2 cycles of the CounterY
  HsyncOut := RegNext(Hsync)
  VsyncOut := RegNext(Vsync)

  val inDisplayArea = (CounterXReg < VGA_H_DISPLAY_SIZE.U) && (CounterYReg < VGA_V_DISPLAY_SIZE.U)
  val pixelX = CounterXReg
  val pixelY = CounterYReg(8,0)


  ////////////////////////////////////
  // CLOCK
  ////////////////////////////////////
  // Generate 1CC pulse at 1 Hz
  val INTERNAL_1S_DIVIDER = 250000 //25000000
  val internal1sEn = WireDefault(false.B)
  val cntReg = RegInit(0.U(25.W))
  cntReg := cntReg + 1.U
  when(cntReg === (INTERNAL_1S_DIVIDER - 1).U) {
    cntReg := 0.U
    internal1sEn := true.B
  }

  val external1sEn = WireDefault(false.B)

  val hourDecReg = RegInit(0.U(2.W)) // 0 - 2
  val hourUniReg = RegInit(0.U(4.W)) // 0 - 9

  val minuteDecReg = RegInit(0.U(3.W)) // 0 - 5
  val minuteUniReg = RegInit(0.U(4.W)) // 0 - 9

  val secondDecReg = RegInit(0.U(3.W)) // 0 - 5
  val secondUniReg = RegInit(0.U(4.W)) // 0 - 9

  val final1sEn = WireDefault(false.B)
  final1sEn := internal1sEn //TODO: MUX this

  when(final1sEn) {
    secondUniReg := secondUniReg + 1.U
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
            }
          }
        }
      }
    }
  }

  ////////////////////////////////////
  // GRAPHIC ENGINE
  ////////////////////////////////////

  val GE_HOUR_DEC_X_MIN = 10
  val GE_HOUR_DEC_X_MAX = 100
  val GE_HOUR_UNI_X_MIN = 110
  val GE_HOUR_UNI_X_MAX = 200
  val GE_MINUTE_DEC_X_MIN = 210
  val GE_MINUTE_DEC_X_MAX = 300
  val GE_MINUTE_UNI_X_MIN = 310
  val GE_MINUTE_UNI_X_MAX = 400
  val GE_SECOND_DEC_X_MIN = 410
  val GE_SECOND_DEC_X_MAX = 500
  val GE_SECOND_UNI_X_MIN = 510
  val GE_SECOND_UNI_X_MAX = 600

  val GE_B3_Y_MIN = 10
  val GE_B3_Y_MAX = 100
  val GE_B2_Y_MIN = 110
  val GE_B2_Y_MAX = 200
  val GE_B1_Y_MIN = 210
  val GE_B1_Y_MAX = 300
  val GE_B0_Y_MIN = 310
  val GE_B0_Y_MAX = 400

  //val GE_VLINE_H_M_X = 205
  //val GE_VLINE_M_S_X = 405
  val GE_HLINE_H_M_S_Y = 405


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

  val inLine = pixelY === GE_HLINE_H_M_S_Y.U && ((pixelX > GE_HOUR_DEC_X_MIN.U && pixelX < GE_HOUR_UNI_X_MAX.U) || (pixelX > GE_MINUTE_DEC_X_MIN.U && pixelX < GE_MINUTE_UNI_X_MAX.U) || (pixelX > GE_SECOND_DEC_X_MIN.U && pixelX < GE_SECOND_UNI_X_MAX.U))


  val GE_DOTS_X = 610

  val GE_DOTS_1_Y_MIN = 10
  val GE_DOTS_1_Y_MAX = 16
  val GE_DOTS_2_Y_MIN = 20
  val GE_DOTS_2_Y_MAX = 26
  val GE_DOTS_3_Y_MIN = 30
  val GE_DOTS_3_Y_MAX = 36
  val GE_DOTS_4_Y_MIN = 40
  val GE_DOTS_4_Y_MAX = 46
  val GE_DOTS_5_Y_MIN = 50
  val GE_DOTS_5_Y_MAX = 56
  val GE_DOTS_6_Y_MIN = 60
  val GE_DOTS_6_Y_MAX = 66
  val GE_DOTS_7_Y_MIN = 70
  val GE_DOTS_7_Y_MAX = 76
  val GE_DOTS_8_Y_MIN = 80
  val GE_DOTS_8_Y_MAX = 86

  val GE_DOTS_9_Y_MIN = 110
  val GE_DOTS_9_Y_MAX = 116
  val GE_DOTS_10_Y_MIN = 120
  val GE_DOTS_10_Y_MAX = 126
  val GE_DOTS_11_Y_MIN = 130
  val GE_DOTS_11_Y_MAX = 136
  val GE_DOTS_12_Y_MIN = 140
  val GE_DOTS_12_Y_MAX = 146

  val GE_DOTS_13_Y_MIN = 210
  val GE_DOTS_13_Y_MAX = 216
  val GE_DOTS_14_Y_MIN = 220
  val GE_DOTS_14_Y_MAX = 226

  val GE_DOTS_15_Y_MIN = 310
  val GE_DOTS_15_Y_MAX = 316

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
    when(inEdgeV || inEdgeH || inLine || inDots){
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
      Red := 3.U
      Green := 0.U
      Blue := 0.U
    } .elsewhen(
      (minuteDecReg(2) && inMinuteDecXArea && inB2YArea) ||
      (minuteDecReg(1) && inMinuteDecXArea && inB1YArea) ||
      (minuteDecReg(0) && inMinuteDecXArea && inB0YArea) ||
      (minuteUniReg(3) && inMinuteUniXArea && inB3YArea) ||
      (minuteUniReg(2) && inMinuteUniXArea && inB2YArea) ||
      (minuteUniReg(1) && inMinuteUniXArea && inB1YArea) ||
      (minuteUniReg(0) && inMinuteUniXArea && inB0YArea)
    ) {
      Red := 0.U
      Green := 3.U
      Blue := 0.U
    } .elsewhen(
      (secondDecReg(2) && inSecondDecXArea && inB2YArea) ||
      (secondDecReg(1) && inSecondDecXArea && inB1YArea) ||
      (secondDecReg(0) && inSecondDecXArea && inB0YArea) ||
      (secondUniReg(3) && inSecondUniXArea && inB3YArea) ||
      (secondUniReg(2) && inSecondUniXArea && inB2YArea) ||
      (secondUniReg(1) && inSecondUniXArea && inB1YArea) ||
      (secondUniReg(0) && inSecondUniXArea && inB0YArea)
    ) {
      Red := 0.U
      Green := 0.U
      Blue := 3.U
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

  RedOut := RegNext(Red)
  GreenOut := RegNext(Green)
  BlueOut := RegNext(Blue)


} //module


object ChiselTop extends App {
  emitVerilog(new ChiselTop(), Array("--target-dir", "src"))
}