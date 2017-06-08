## Java Spring Backend

#Quick Setup
1. Atunci cand doriti sa deschideti proiectul in editorul vostru preferat nu il deschideti cu "Open", ci cu "Import". Eu personal, daca il deschid cu open nu mai am validarea documentelor java: "spell checker", "intellisense".
2. Serverul se ruleaza de la linia de comanda, atunci cand va aflati in calea "\Back\BitChess" cu comanada:
	mvn spring-boot:run.
	Observatie: Nu imi mai amintesc sigur dar stiu ca trebuie setata ceva variabila de sitem, in caz ca nu recunoaste comanda.
3. Serverul il gasiti la portul 4500.

Fixes:
	https://stackoverflow.com/questions/6111408/maven2-missing-artifact-but-jars-are-in-place


#Session management
1. JSON Web Tokens
	[JSON Web Tokens](https://jwt.io)
	[RFC 7519](https://tools.ietf.org/html/rfc7519)
	[Java JWT](https://bitbucket.org/b_c/jose4j/wiki/Home)