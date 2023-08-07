package body YAA.Functions is

   --  For any sufficiently continuous function (?)
   --  f(a0 + a1e1 + a2e2 + a12e12)
   --    = f(a0) + (a1e1 + a2e2 + a12e12)f'(a0)
   --             + 0.5*(a1e1 + a2e2 + a12e12)^2f''(a0)
   --    = f(a0) + (a1e1 + a2e2 + a12e12)f'(a0)
   --             + 0.5*(a1^2e1^2 + a2^2e2^2 + a12^2e12^2
   --                + 2a1a2e1e2 + 2a1a12e1e12 + 2a2a12e2e12)f''(a0)
   --    = f(a0) + (a1e1 + a2e2 + a12e12)f'(a0) + 0.5*(2a1a2)^2f''(a0)
   --    = f(a0) + a1f'(a0)e1 + a2f'(a0)e2 + (a12f'(a0) + a1a2f''(a0))e12

   function Cos (X : Dual_Types.Dual) return Dual_Types.Dual is
   begin
      return (
         Re => CosR (X.Re),
         Im1 => -X.Im1 * SinR (X.Re),
         Im2 => -X.Im2 * SinR (X.Re),
         Im12 => -X.Im12 * SinR (X.Re) - X.Im1 * X.Im2 * CosR (X.Re));
   end Cos;

end YAA.Functions;
