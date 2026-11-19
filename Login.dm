client
	New()
		..()
		mob = new /mob/login
		mob.loc = locate(1,1,1)



mob
	var
		travado = 0

	Move()
		if(travado)
			return
		return ..()

mob/login
	Login()
		..()

		travado = 1

		var/opcao = input(src, "Escolha uma opção") in list(
			"Novo",
			"Carregar",
			"Deletar"
		)

		switch(opcao)

			if("Novo")
				CreateCharacter()

			if("Carregar")
				if(fexists("saves/[ckey(key)].sav"))
					LoadCharacter()
				else
					src << "Nenhum personagem encontrado."
					Login() // volta pro menu

			if("Deletar")
				if(fexists("saves/[ckey(key)].sav"))
					fdel("saves/[ckey(key)].sav")
					src << "Personagem deletado."
				else
					src << "Nada para deletar."

				Login() // volta pro menu