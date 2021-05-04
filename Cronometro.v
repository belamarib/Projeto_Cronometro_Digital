module Cronometro(clock, mostrador0, mostrador1, mostrador2, mostrador3, botao);

input clock;
input[3:0] botao;
output reg[3:0] mostrador0, mostrador1, mostrador2, mostrador3;

//botao = 1111 -> padrao (nao apertar nenhum botao)
//botao = 0111 -> contar (apertar botao[3])
//botao = 1011 -> pausar (apertar botao[2])
//botao = 1101 -> parar (apertar botao[1])
//botao = 1110 -> resetar (apertar botao[0])
reg[13:0] numero;
initial numero <= 14'd0;
parameter [1:0] contar = 2'b00, pausar = 2'b01, resetar = 2'b10, parar = 2'b11;
reg[1:0] estado;
initial estado <= resetar;
reg[1:0] prox_estado;
initial prox_estado <= resetar;
reg[3:0] numero0;
reg[3:0] numero1;
reg[3:0] numero2;
reg[3:0] numero3;
initial numero0 <= 4'd0;
initial numero1 <= 4'd0;
initial numero2 <= 4'd0;
initial numero3 <= 4'd0;


always@(posedge clock)
begin
  case(estado)
  contar:
  begin
    if (numero < 14'd9999)
    begin
      numero = numero + 14'd1;
		if (numero0 < 4'd9)
		begin
			numero0 = numero0 + 4'd1;
		end
		else
		begin
			numero0 = 4'd0;
			if(numero1 < 4'd9)
			begin
				numero1 = numero1 + 4'd1;
			end
			else
			begin
				numero1 = 4'd0;
				if (numero2 < 4'd9)
				begin
					numero2 = numero2 + 4'd1;
				end
				else
				begin
					numero2 = 4'd0;
					if (numero3 < 4'd9)
					begin
						numero3 = numero3 + 4'd1;
					end
					else
					begin
						numero3 = 0;
					end
				end
			end
		end
    end
    else
    begin
      numero = 14'd0;
		numero0 = 4'd0;
		numero1 = 4'd0;
		numero2 = 4'd0;
		numero3 = 4'd0;
    end
		mostrador0 = numero0;
		mostrador1 = numero1;
		mostrador2 = numero2;
		mostrador3 = numero3;
  end
  pausar:
  begin
    if (numero < 14'd9999)
    begin
      numero = numero + 14'd1;
		if (numero0 < 4'd9)
		begin
			numero0 = numero0 + 4'd1;
		end
		else
		begin
			numero0 = 4'd0;
			if(numero1 < 4'd9)
			begin
				numero1 = numero1 + 4'd1;
			end
			else
			begin
				numero1 = 4'd0;
				if (numero2 < 4'd9)
				begin
					numero2 = numero2 + 4'd1;
				end
				else
				begin
					numero2 = 4'd0;
					if (numero3 < 4'd9)
					begin
						numero3 = numero3 + 4'd1;
					end
					else
					begin
						numero3 = 0;
					end
				end
			end
		end
    end
    else
    begin
      numero = 14'd0;
		numero0 = 4'd0;
		numero1 = 4'd0;
		numero2 = 4'd0;
		numero3 = 4'd0;
    end
  end
  resetar:
  begin
		numero = 14'd0;
		numero0 = 4'd0;
		numero1 = 4'd0;
		numero2 = 4'd0;
		numero3 = 4'd0;
		mostrador0 = 4'd0;
		mostrador1 = 4'd0;
		mostrador2 = 4'd0;
		mostrador3 = 4'd0;
  end
  endcase
end



always@(botao)
begin
	if (botao == 4'b1111)
	begin
		estado <= prox_estado;
	end
	else
	begin
		case (botao)
		4'b0111: //contar
		begin
		if (estado != pausar)
		begin
			prox_estado <= contar;
		end
		else
		begin
			prox_estado <= pausar;
		end
		end
		4'b1011: //pausar
		begin
			if (estado == contar)
			begin
				prox_estado <= pausar;
			end
			else
			begin
				prox_estado <= contar;
			end
		end
		4'b1101: //parar
		begin
			prox_estado <= parar;
		end
		default: //resetar
		begin
			prox_estado <= resetar;
		end
		endcase
	end
end
endmodule
