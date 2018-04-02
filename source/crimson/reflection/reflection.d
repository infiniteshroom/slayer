module crimson.reflection;

class Reflection {
   public static Rt callFunction(Rt, T...)( Rt delegate(T) dg, T args) {
        return dg(args);
    }

    public static Rt callFunction(Rt, T...)( Rt function(T) dg, T args) {
            return dg(args);
    }

}