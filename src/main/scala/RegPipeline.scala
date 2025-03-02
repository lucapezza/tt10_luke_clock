import chisel3._
import chisel3.util._


object RegPipeline {
  /** Returns a pipeline of registers of the input type connected to the signal `input` and with no reset value. */
  def apply[T <: Data](input: T, pipeDepth: Int): T = {
    require(pipeDepth >= 0, "Pipeline depth must have non-negative value.")
    if (pipeDepth == 0) {
      val ret = input
      return ret
    } else {
      val model = (input.cloneType).asInstanceOf[T]
      val pipeReg = Reg(Vec(pipeDepth, model))
      val ret = pipeReg(0)
      pipeReg(pipeDepth - 1) := input
      for (i <- 0 until pipeDepth - 1) {
        pipeReg(i) := pipeReg(i + 1)
      }
      return ret
    }
  }

  /** Returns a pipeline of registers of the input type connected to the signal `input` and with specified reset. */
  def apply[T <: Data](input: T, pipeDepth: Int, init: T): T = {
    require(pipeDepth >= 0, "Pipeline depth must have non-negative value.")
    if (pipeDepth == 0) {
      val ret = input
      return ret
    } else {
      val model = (input.cloneType).asInstanceOf[T]
      val pipeReg = RegInit(VecInit(Seq.fill(pipeDepth)(init)))
      val ret = pipeReg(0)
      pipeReg(pipeDepth - 1) := input
      for (i <- 0 until pipeDepth - 1) {
        pipeReg(i) := pipeReg(i + 1)
      }
      return ret
    }
  }
}