package body YAA is

   function Derivative (F : access function (X : Dual) return Dual; X : Real)
      return Real is
      D : constant Dual := (Re => X, Im1 => 1.0, others => 0.0);
   begin
      return F (D).Im1;
   end Derivative;

   function Second_Derivative (
      F : access function (X : Dual) return Dual;
      X : Real) return Real
   is
      D : constant Dual := (Re => X, Im1 => 1.0, Im2 => 1.0, Im12 => 0.0);
   begin
      return F (D).Im12;
   end Second_Derivative;

   function Gradient (
      F : access function (Args : ArrayT) return Dual;
      V : RealArrayT)
   return Gradient_Type is
      R : Gradient_Type (V'Range);
      VDual : ArrayT (V'Range);
   begin
      for I in V'Range loop
         for J in V'Range loop
            VDual (J) :=  (
               Re => V (J),
               Im1 => (if I = J then 1.0 else 0.0),
               others => 0.0);
         end loop;
         R (I) := F (VDual).Im1;
      end loop;
      return R;
   end Gradient;

end YAA;
