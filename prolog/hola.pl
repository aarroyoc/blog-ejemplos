main :- 
	write("Hola Mundo"),
	nl,
	write("¿Cuál es tu nombre? "),
	read_string(user_input,['\n'],[],_,Nombre),
	write("Hola "),write(Nombre),nl,
	halt.
