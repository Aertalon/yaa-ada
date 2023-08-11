package body YAA.Functions is

   One : constant Real := Real (1.0);
   Two : constant Real := Real (2.0);
   Four : constant Real := Real (4.0);

   --  For any sufficiently continuous function (?)
   --  f(a0 + a1e1 + a2e2 + a12e12)
   --    = f(a0) + (a1e1 + a2e2 + a12e12)f'(a0)
   --             + 0.5*(a1e1 + a2e2 + a12e12)^2f''(a0)
   --    = f(a0) + (a1e1 + a2e2 + a12e12)f'(a0)
   --             + 0.5*(a1^2e1^2 + a2^2e2^2 + a12^2e12^2
   --                + 2a1a2e1e2 + 2a1a12e1e12 + 2a2a12e2e12)f''(a0)
   --    = f(a0) + (a1e1 + a2e2 + a12e12)f'(a0) + 0.5*(2a1a2)^2f''(a0)
   --    = f(a0) + a1f'(a0)e1 + a2f'(a0)e2 + (a12f'(a0) + a1a2f''(a0))e12

   function DerivativesToDual (X : Dual; F, FPrime, FSecond : Real)
   return Dual is
   begin
      return (
         Re => F,
         Im1 => X.Im1 * FPrime,
         Im2 => X.Im2 * FPrime,
         Im12 => X.Im12 * FPrime + X.Im1 * X.Im2 * FSecond);
   end DerivativesToDual;

   --  f(x) = x^q
   --  f'(x) = qx^(q-1)
   --  f''(x) = q * (q-1) * x^(q-2)
   function Power (X : Dual; Q : Real) return Dual is
      F : constant Real := PowerR (X.Re, Q);
      FPrime : constant Real := Q * PowerR (X.Re, Q - One);
      FSecond : constant Real := Q * (Q - One) * PowerR (X.Re, Q - Two);
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Power;

   --  f(x) = x^0.5
   --  f'(x) = 0.5x^-0.5 = 1 / (2 * f(x))
   --  f''(x) = -0.25x^-1.5 = - 1/( 4 * f'(x)^3)
   function Sqrt (X : Dual) return Dual is
      F : constant Real := SqrtR (X.Re);
      FPrime : constant Real := One / (Two * F);
      FSecond : constant Real := -One / (Four * F * F * F);
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Sqrt;

   --  f(x) = log(x)
   --  f'(x) = x^-1
   --  f''(x) = -x^-2 = - f'(x)^2
   function Log (X : Dual) return Dual is
      F : constant Real := LogR (X.Re);
      FPrime : constant Real := One / (X.Re);
      FSecond : constant Real := -FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Log;

   --  f(x) = exp(x)
   --  f'(x) = exp(x)
   --  f''(x) = exp(x)
   function Exp (X : Dual) return Dual is
      F : constant Real := ExpR (X.Re);
   begin
      return DerivativesToDual (X, F, F, F);
   end Exp;

   --  f(x) = cos(x)
   --  f'(x) = -sin(x)
   --  f''(x) = -cos(x)
   function Cos (X : Dual) return Dual is
      F : constant Real := CosR (X.Re);
      FPrime : constant Real := -SinR (X.Re);
   begin
      return DerivativesToDual (X, F, FPrime, -F);
   end Cos;

   --  f(x) = sin(x)
   --  f'(x) = cos(x)
   --  f''(x) = -sinx(x)
   function Sin (X : Dual) return Dual is
      F : constant Real := SinR (X.Re);
      FPrime : constant Real := CosR (X.Re);
   begin
      return DerivativesToDual (X, F, FPrime, -F);
   end Sin;

   --  f(x) = tan(x)
   --  f'(x) = 1 + tan^2(x)
   --  f''(x) = 2 tan(x) (tan(x))'
   function Tan (X : Dual) return Dual is
      F : constant Real := TanR (X.Re);
      FPrime : constant Real := One + F * F;
      FSecond : constant Real := Two * F * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Tan;

   --  f(x) = cot(x)
   --  f'(x) = -1 - cot^2(x)
   --  f''(x) = - 2 cot(x) (cot(x))'
   function Cot (X : Dual) return Dual is
      F : constant Real := CotR (X.Re);
      FPrime : constant Real := -One - F * F;
      FSecond : constant Real := -Two * F * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Cot;

   --  f(x) = arccos(x)
   --  f'(x) = -(1 - x^2)^(-0.5)
   --  f''(x) = -0.5 * 2x * (1 - x^2)^(-1.5) = -x * f'(x)^3
   function Arccos (X : Dual) return Dual is
      F : constant Real := ArccosR (X.Re);
      FPrime : constant Real := -One / SqrtR (One - X.Re * X.Re);
      FSecond : constant Real := -X.Re * FPrime * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arccos;

   --  f(x) = arcsin(x)
   --  f'(x) = (1 - x^2)^(-0.5)
   --  f''(x) = 0.5 * 2x * (1 - x^2)^(-1.5) = x * f'(x)^3
   function Arcsin (X : Dual) return Dual is
      F : constant Real := ArcsinR (X.Re);
      FPrime : constant Real := One / SqrtR (One - X.Re * X.Re);
      FSecond : constant Real := X.Re * FPrime * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arcsin;

   --  f(x) = arctan(x)
   --  f'(x) = (1 + x^2)^(-1)
   --  f''(x) = - 2x * (1 - x^2)^(-2) = -2x * f'(x)^2
   function Arctan (X : Dual) return Dual is
      F : constant Real := ArctanR (X.Re);
      FPrime : constant Real := One / (One + X.Re * X.Re);
      FSecond : constant Real := -Two * X.Re * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arctan;

   --  f(x) = arccot(x)
   --  f'(x) = -(1 + x^2)^(-1)
   --  f''(x) = 2x * (1 - x^2)^(-2) = 2x * f'(x)^2
   function Arccot (X : Dual) return Dual is
      F : constant Real := ArccotR (X.Re);
      FPrime : constant Real := -One / (One + X.Re * X.Re);
      FSecond : constant Real := Two * X.Re * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arccot;

   --  f(x) = cosh(x)
   --  f'(x) = sinh(x)
   --  f''(x) = cosh(x)
   function Cosh (X : Dual) return Dual is
      F : constant Real := CoshR (X.Re);
      FPrime : constant Real := SinhR (X.Re);
   begin
      return DerivativesToDual (X, F, FPrime, F);
   end Cosh;

   --  f(x) = sinh(x)
   --  f'(x) = cosh(x)
   --  f''(x) = sinh(x)
   function Sinh (X : Dual) return Dual is
      F : constant Real := SinhR (X.Re);
      FPrime : constant Real := CoshR (X.Re);
   begin
      return DerivativesToDual (X, F, FPrime, F);
   end Sinh;

   --  f(x) = tanh(x)
   --  f'(x) = 1 - tanh(x)^2
   --  f''(x) = -2tanh(x)(tanh(x))'
   function Tanh (X : Dual) return Dual is
      F : constant Real := TanhR (X.Re);
      FPrime : constant Real := One - F * F;
      FSecond : constant Real := -Two * F * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Tanh;

   --  f(x) = coth(x)
   --  f'(x) = 1 - coth(x)^2
   --  f''(x) = -coth(x)(coth(x))'
   function Coth (X : Dual) return Dual is
      F : constant Real := CothR (X.Re);
      FPrime : constant Real := One - F * F;
      FSecond : constant Real := -Two * F * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Coth;

   --  f(x) = arccosh(x)
   --  f'(x) = (x^2 - 1)^-0.5
   --  f''(x) = -0.5 *2x * (x^2 - 1)^-1.5 = -x * f'(x)^3
   function Arccosh (X : Dual) return Dual is
      F : constant Real := ArccoshR (X.Re);
      FPrime : constant Real := One / SqrtR (X.Re * X.Re - One);
      FSecond : constant Real := -X.Re * FPrime * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arccosh;

   --  f(x) = arcsinh(x)
   --  f'(x) = (x^2 + 1)^-0.5
   --  f''(x) = -0.5 *2x * (x^2 + 1)^-1.5 = -x * f'(x)^3
   function Arcsinh (X : Dual) return Dual is
      F : constant Real := ArcsinhR (X.Re);
      FPrime : constant Real := One / SqrtR (X.Re * X.Re + One);
      FSecond : constant Real := -X.Re * FPrime * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arcsinh;

   --  f(x) = arctanh(x)
   --  f'(x) = (1 - x^2)^-1
   --  f''(x) = 2x * (1 - x^2)^-2 = 2x * f'(x)^2
   function Arctanh (X : Dual) return Dual is
      F : constant Real := ArctanhR (X.Re);
      FPrime : constant Real := One / (One - X.Re * X.Re);
      FSecond : constant Real := Two * X.Re * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arctanh;

   --  f(x) = arccoth(x)
   --  f'(x) = -(1 - x^2)^-1
   --  f''(x) = -2x * (1 - x^2)^-2 = -2x * f'(x)^2
   function Arccoth (X : Dual) return Dual is
      F : constant Real := ArctanhR (X.Re);
      FPrime : constant Real := -One / (One - X.Re * X.Re);
      FSecond : constant Real := -Two * X.Re * FPrime * FPrime;
   begin
      return DerivativesToDual (X, F, FPrime, FSecond);
   end Arccoth;

end YAA.Functions;
