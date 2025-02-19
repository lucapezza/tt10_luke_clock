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
  val pixelY = CounterYReg

  val Red = Wire(UInt(2.W))
  val Green = Wire(UInt(2.W))
  val Blue = Wire(UInt(2.W))
  Red := 0.U
  Green := 0.U
  Blue := 0.U

  val cntReg = RegInit(0.U(20.W))
  cntReg := cntReg + 1.U


//when(inDisplayArea) {
  when(pixelX * pixelY  === cntReg){
    when(pixelX(0) === 0.U){
      when(pixelY(0) === 0.U) {
        //white
        Red := 3.U
        Green := 3.U
        Blue := 3.U
      }.otherwise {
        //black
        Red := 0.U
        Green := 0.U
        Blue := 0.U
      }
    }.otherwise {
      when(pixelY(0) === 0.U) {
        //black
        Red := 0.U
        Green := 0.U
        Blue := 0.U
      }.otherwise {
        //white
        Red := 3.U
        Green := 3.U
        Blue := 3.U
      }
    }
  } .otherwise {
    //black
    Red := 0.U
    Green := 0.U
    Blue := 0.U
  }

  RedOut := RegNext(Red)
  GreenOut := RegNext(Green)
  BlueOut := RegNext(Blue)
}








  /*
    // Blink with 1 Hz
    val cntReg = RegInit(0.U(32.W))
    val ledReg = RegInit(0.U(1.W))
    cntReg := cntReg + 1.U
    when (cntReg === 25000000.U) {
      cntReg := 0.U
      ledReg := ~ledReg
    }
    io.uo_out := ledReg ## add
  }
  */

object ChiselTop extends App {
  emitVerilog(new ChiselTop(), Array("--target-dir", "src"))
}