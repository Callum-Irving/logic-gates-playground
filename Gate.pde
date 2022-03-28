abstract class BaseGate {
  public abstract int inputs();
  
  public abstract boolean compute(boolean[] inputs);
  
  public ArrayList<BaseGate> outputs;
}
