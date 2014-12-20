
package body Connect
with SPARK_Mode is

   function Get_Snake (A: Steps) return Walk is

      -- Get a random walk in 2D space on the square
      -- lattice.

      Walked: Walk:=(others=>(0,0));
      Next: Vector;

   begin
      for I in Index'First+1 .. Index'Last loop

         case A(I) is
         when Up =>
            Next:=(Walked(I-1)(1),Walked(I-1)(2)+1);
         when Down =>
               Next:=(Walked(I-1)(1),Walked(I-1)(2)-1);
         when Left =>
               Next:=(Walked(I-1)(1)-1,Walked(I-1)(2));
         when Right =>
               Next:=(Walked(I-1)(1)+1,Walked(I-1)(2));
         end case;

         Walked(I):=Next;

         -- pragma Loop_Invariant (Current(1)<=I and Current(1)>=-I and Current(2)<=I and Current(2)>=-I);
         -- Loop invariant to ensure an absence of the overflow in the next
         -- step of updating Next

         pragma Loop_Invariant (for all J in Index'First+1 .. I =>
                                 (Walked(J)(1)-Walked(J-1)(1)=1 and Walked(J)(2)-Walked(J-1)(2)=0) or else
                                 (Walked(J)(1)-Walked(J-1)(1)=0 and Walked(J)(2)-Walked(J-1)(2)=1) or else
                                 (Walked(J)(1)-Walked(J-1)(1)=0 and Walked(J)(2)-Walked(J-1)(2)=-1) or else
                                 (Walked(J)(1)-Walked(J-1)(1)=-1 and Walked(J)(2)-Walked(J-1)(2)=0));

         pragma Loop_Invariant (for all J in Index'First+1 .. I => Walked(J)(1)<=J and Walked(J)(1)>=-J and Walked(J)(2)<=J and Walked(J)(2)>=-J);

      end loop;
      return Walked;

   end Get_Snake;


   function Get_Distance (W: Walk) return Integer is

      SX: Integer:=0;
      SY: Integer:=0;

   begin

      for I in Index'First+1 .. Index'Last loop

         pragma Loop_Invariant (SX<I*Index'Last and SX>(-I)*Index'Last and SY<I*Index'Last and SY>(-I)*Index'Last);

         SX:=SX+W(I)(1);
         SY:=SY+W(I)(2);


      end loop;

      return SX*SX+SY*SY;

   end Get_Distance;


end Connect;
