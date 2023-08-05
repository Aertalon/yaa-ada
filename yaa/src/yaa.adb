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

end YAA;
