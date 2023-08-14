[![Build status](https://github.com/Aertalon/yaa-ada/actions/workflows/build.yml/badge.svg)](https://github.com/Aertalon/yaa-ada/actions/workflows/build.yml)
[![Test status](https://github.com/Aertalon/yaa-ada/actions/workflows/test.yml/badge.svg)](https://github.com/Aertalon/yaa-ada/actions/workflows/test.yml)

# yaa-ada

An Ada 2012 library for autodifferentiation based on dual numbers.

## Usage

The following snippet shows how to use yaa to compute
gradient and hessian of a function of three variables.

Note: currently the syntax is admittedly not user friendly.

```ada

with YAA;
with YAA.Functions;

procedure Example is

      --  instantiate/use the necessary packages
      package YAA_F is new YAA (Real => Float);
      package YAA_Functions_F is new YAA_F.Functions;
      use YAA_F.Real_Arrays;

      type FGenericDualArray is array (Positive range <>)
         of YAA_F.Dual_Types.Dual;
      type FGenericRealArray is array (Positive range <>) of Float;

      --  Define a generic function and then instantiate
      --  or defined it directly in terms of dual numbers

      generic
         type T is private;
         type ArrayT is array (Positive range <>) of T;
         with function "*" (X : T; Y : T) return T;
         with function "+" (X : T; Y : T) return T;
         with function To_T (X : Float) return T;
         with function ExpT (X : T) return T;
         with function SinT (X : T) return T;
      function F (Args : ArrayT) return T;

      function F (Args : ArrayT) return T is
      begin
         --  f(X, Y, Z)     = X * Exp(Y * sin(Z) + 2)
         --  df(X, Y, Z)/dX = Exp(Y * sin(Z) + 2)
         --  df(X, Y, Z)/dY = X * Exp(Y * sin(Z) + 2) * sin(Z)
         --  df(X, Y, Z)/dZ = X * Exp(Y * sin(Z) + 2) * Y * cos(Z)
         return Args (1) * ExpT (Args (2) * SinT (Args (3)) + To_T (2.0));
      end F;

      function F_Dual is new F (
         T => YAA_F.Dual_Types.Dual,
         ArrayT => FGenericDualArray,
         "*" => YAA_F.Dual_Types."*",
         "+" => YAA_F.Dual_Types."+",
         To_T => YAA_F.Dual_Types.To_Dual,
         ExpT => YAA_Functions_F.Exp,
         SinT => YAA_Functions_F.Sin);

      --  instantiate gradient and hessian functions
      function GradientF is new YAA_F.Gradient (
         ArrayT => FGenericDualArray,
         RealArrayT => FGenericRealArray);

      function HessianF is new YAA_F.Hessian (
         ArrayT => FGenericDualArray,
         RealArrayT => FGenericRealArray);

      subtype HessianT is YAA_F.Real_Arrays.Real_Matrix (1 .. 3, 1 .. 3);
      subtype GradientT is YAA_F.Real_Arrays.Real_Vector (1 .. 3);

      Args : FGenericRealArray := (0.0, 0.0, 0.0);

      G : GradientT;
      H: HessianT;

begin

   Args := (1.0, 2.0, 3.0);
   G := GradientF (F_Dual'Access, Args);
   H := HessianF (F_Dual'Access, Args);

end Example;
```

## Dependencies

In order to build the library, you need to have:

 * An Ada 2012 compiler

 * [Alire][url-alire]

Optional dependencies:

 * `make`


## Tests

Unit tests are provided in the folder `tests`.
Tests are built and run via
```
$ make tests
```

Coverage report from unit test (using `gnatcoverage`) is generated via
```
$ make coverage
```

## Contributing

To be written.

## Acknowledgements

The structure of this repo is heavily influenced by Onox' [json-ada library][url-json-ada].

  [url-alire]: https://alire.ada.dev/
  [url-json-ada]: https://github.com/Aertalon/yaa-ada

