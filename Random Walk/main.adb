with Connect; use Connect;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Main is

   type My_Float is new Float;
   Sum: Integer:=0;
   Viper: Walk;
   A: Steps;
   Average: Float;

   package Random_Move is new Ada.Numerics.Discrete_Random (Move);
   use Random_Move;
   G : Generator;


   begin

     for K in 1 .. 100000 loop

       Reset (G);

       for K in Steps'Range loop
          A(K):=Random(G);
       end loop;

       Viper:=Get_Snake(A);

       Sum:=Sum+Get_Distance(Viper);
       Put_Line(Integer'Image(Get_Distance(Viper)));
   end loop;

   Average:=Float(Sum)/100000.0;
   Put_Line(Float'Image(Average));

end Main;
