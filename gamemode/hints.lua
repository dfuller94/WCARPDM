local rpdmhints = {
"Press F1 for a list of commands",
"This is not RP. It is more like base wars.",
"say /buyturret to buy a sentry gun for $300",
"You just lost the game.",
"Shooting every person randomly on this server usually ends with everyone teaming up against you.",
"Police get a higher payday than other classes and spawn with weapons. Good for those who don't want to make a base.",
"The mob spawns with armor, can run faster, and can buy various things to make more money. Good for people who want to make a base.",
"If anyone is saying that killing on this server is against the rules, they are a lying sack of shit. Please destroy these mingebags.",
"If you have a base set up and you hear beeping and can see 'BOMB' right outside of your base, then you should probably go and defuse it.",
"Is an enemy holed up in a secure place and blowtorch isnt helping much? Buy a bomb by saying /buybomb. It costs 5000, but can ruin a base.",
"Before you start accusing people of cheating or abusing admin, or whatever bullshit your butthurt self feels like shouting, press f1, and buy some of the upgrades listed there.",
"One of the best ways to keep your base from being raided is to team up with people. People who won't go around shooting people that are looking for people to raid.",
"There is no such thing as a perfect base, if you just block everything with props, they will weld it, if you keep them from doing that, they will probably use the bigbomb.",
"Props are not weapons! Get a gun instead. Press F1 to learn how.",
"Dying slowly from poison? Get a medic to heal you, or say /buyantidote",
"If there is a gun dealer, you can still buy shipments, they will just cost double the normal amount",
"If you are low on money, buy some stuff to make more money. Press F1 to learn how.",
"Press F2 to open the buy menu."
}

function giveHint()
	PrintMessageAll( HUD_PRINTTALK , rpdmhints[math.random(1,#rpdmhints)])
end

timer.Create( "hints", 120, 0, giveHint )