
if( HelpGUI ) then

	for k, v in pairs( HelpGUI ) do
	
		v:Remove();
		HelpGUI[k] = nil;
	
	end

end
HelpGUI = {}

local currentpage = 1
local pages = 4
local htmlbrick = nil
local pagelbl = nil
local tsize = 1
if ScrW()>1000 then
	tsize=2
end

local helppages = {[[
<body bgcolor=CCCCCC><FONT FACE="Courier New" SIZE="]] .. tostring(tsize) .. [[">
<b><h4>WCARPDM v2.0 (Modified from Darkrp 2.1a)</h4></b><br>
<u><h4>Basic Chat Commands</h4></u><br>
say any of these commands in chat to use them.<br>
<br>
<b>/help</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Opens this menu<br>
<b>/job (Job Title)</b>&#160;&#160;&#160;&#160;&#160;-- Sets your job title<br>
<b>/w (Message)</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Whisper a message to really close players<br>
<b>/y (Message)</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Yell a message to nearby players<br>
<b>//, /ooc, /a</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- OOC tags (kind of useless for this kind of server.)<br>
<b>/pm (Name) (Message)</b> -- Send a private message to a player<br>
<b>/give (Amount)</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Give money to the player you're looking at<br>
<b>/moneydrop (Amount)</b>&#160;&#160;-- Drop some money that can then be picked up by anyone<br>
<b>/title (Title)</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Give a title to a door you're looking at that you own<br>
<b>/addowner (Name)</b>&#160;&#160;&#160;&#160;&#160;-- Add an owner to a door you're looking at that you own<br>
<b>/removeowner (Name)</b>&#160;&#160;-- Remove an owner from a door that you own<br>
<b>/r</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Use radio to send message to Mayor and cops<br>
<b>/cr</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Send a message to Mayor and cops<br>
<b>/votemute (Player ID)</b>-- Vote to disable a player's microphone<br>
<b>/write,/type</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Write a letter, press use on a letter to read it<br>
&#160&#160;<i>-each version of this command uses a different font</i><br>
<b>/sign</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Create a sign. Color is same as your color in WCARPDM Settings<br>
<br>
<h4><b><u>Joining Teams</b></u></h4><br>
<b>/cop, /votecop, /cp</b>&#160;&#160;-- Become a cop<br>
<b>/voteow, /chief</b>&#160;&#160;&#160;&#160;&#160;&#160;-- Vote to become OverWatch<br>
<b>/votespecops</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Vote to become Spec. Ops<br>
<b>/votemayor</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Vote to become Mayor<br>
<b>/citizen</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Turn back into a normal citizen<br>
<b>/gangster</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Become a Gangster<br>
<b>/cook</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Become a Cook<br>
<b>/gundealer</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Become a Gun Dealer<br>
<b>/mobboss</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Become the Mob Boss<br>
<b>/votehitman</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;-- Vote to become a Hitman<br>
&#160&#160;<i>-Can only be used if Gangster/Mobboss</i><br>
<br>
There is no "new life rule" or anything similar. Anyone can kill anyone for any reason,
which includes "because they want to." This is not actually an RP server, it is base wars,
or deathmatch, depending on how you play the game. If someone kills you, don't get mad,
get even. Press F2, or click some buttons and learn how to play the game.
</body></FONT>
]],[[
<body bgcolor=CCCCCC><FONT FACE="Courier New" SIZE="]] .. tostring(tsize) .. [[">
<b><h4>WCARPDM&#160;v2.0&#160;(Modified&#160;from&#160;Darkrp&#160;2.1a)</h4></b><br>
<u><h4>Weapons</h4></u><br>
Command&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Price&#160;&#160;&#160;&#160;Ammo&#160;type&#160;&#160;&#160;&#160;&#160;&#160;Description<br>
<br>
<b>/buyknife</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$150&#160;&#160;&#160;&#160;&#160;-&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Buy a knife<br>
<b>/buypipebomb</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;$150&#160;&#160;&#160;&#160;&#160;-&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Buy 3 pipe bombs<br>
<b>/buylockpick</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;$150&#160;&#160;&#160;&#160;&#160;-&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Unlocks doors you don't own<br>
<b>/buydartgun</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$300&#160;&#160;&#160;&#160;&#160;ammo:&#160;dart&#160;&#160;&#160;&#160;&#160;Stuns players that are hit with it<br>
<b>/buywelder</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$750&#160;&#160;&#160;&#160;&#160;-&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Deletes other peoples props<br>
&#160;<i> -Blocking yourself in order to weld into their base so that they cannot kill you can get you banned. Don't do it.</i><br>
<br>
<b>/buypistol</b>&#160;(followed&#160;by&#160;any&#160;of&#160;the&#160;below,&#160;ALL&#160;use&#160;pistol&#160;ammo)<br>
P228&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$200<br>
Deagle&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$210<br>
Glock&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$220<br>
FiveseveN&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$230<br>
USP&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$240<br>
Elites&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$350<br>
Mac10&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$420<br>
TMP&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$530<br>
<br>
<b>/buyshipment</b>&#160;(followed&#160;by&#160;any&#160;of&#160;the&#160;below.)<br>
&#160;<i> -if there are gun dealers, price is doubled.</i><br>
<br>
Mac10&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1100&#160;&#160;&#160;&#160;ammo:&#160;pistol<br>
TMP&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1200&#160;&#160;&#160;&#160;ammo:&#160;pistol<br>
UMP&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1300&#160;&#160;&#160;&#160;ammo:&#160;pistol<br>
m4&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1400&#160;&#160;&#160;&#160;ammo:&#160;rifle<br>
Shotgun&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1500&#160;&#160;&#160;&#160;ammo:&#160;shotgun<br>
MP5&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1600&#160;&#160;&#160;&#160;ammo:&#160;pistol<br>
Galil&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1700&#160;&#160;&#160;&#160;ammo:&#160;rifle<br>
AUG&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1800&#160;&#160;&#160;&#160;ammo:&#160;rifle<br>
RPG&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$1900&#160;&#160;&#160;&#160;ammo:&#160;rocket<br>
AK47&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$2000&#160;&#160;&#160;&#160;ammo:&#160;rifle<br>
FlameThrower&#160;&#160;&#160;&#160;&#160;&#160;&#160;$2100&#160;&#160;&#160;&#160;ammo:&#160;fuel<br>
Sniper&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$2200&#160;&#160;&#160;&#160;ammo:&#160;sniper<br>
AutoShotgun&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$2400&#160;&#160;&#160;&#160;ammo:&#160;shotgun<br>
M249&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$2800&#160;&#160;&#160;&#160;ammo:&#160;rifle<br>
AutoSnipe&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$3500&#160;&#160;&#160;&#160;ammo:&#160;sniper<br>
Grenade&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$300&#160;&#160;&#160;&#160;&#160;-&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Cops/mobboss buy at normal price<br>
StunGrenade&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$250&#160;&#160;&#160;&#160;&#160;-&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Cops can buy for normal price<br>
GasGrenade&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$400&#160;&#160;&#160;&#160;&#160;-<br>
Molotov&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$400&#160;&#160;&#160;&#160;&#160;-<br>
<br>
<b>/buybomb</b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;$5000&#160;&#160;&#160;&#160;Not&#160;handheld&#160;&#160;&#160;Destroys everything near it<br>
&#160;<i> -Hold use on the bomb to arm it. Bomb explodes after 60 seconds unless defused.<br>
&#160; -Explosion effect is Cinematic Explosion, made by Fatal Muffin<br>
&#160; -This bomb will destroy all props near it, damage through walls, and leave a bunch of smaller bombs to completely bring ruin to whatever it's blowing up.<br>
&#160; -If you have someone block the bomb off with props so that it can't be defused, we will ban both of you. There is no debating this.</i><br>

</body></FONT>
]],[[
<BODY BGCOLOR=CCCCCC><FONT FACE="Courier New" SIZE="]]..tostring(tsize)..[[">
<h4><b>WCARPDM v2.0 (Modified from Darkrp 2.1a)</b></H4>
<BR><BR>

<u><h4>Structures</h4></u>
<b>/buygenerator</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Provides
up to 5 power to structures near it<BR>&nbsp; <I>-Generator
automatically powers structures near it upon buying it<BR>&nbsp;
-Costs the owner of it $5 per minute to
run.<BR></I><b>/buyradar</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Allows
the owner to use <b>/scan</b>
on players to find them<BR>&nbsp;<I>
-Requires 2 power to scan or charge<BR>&nbsp; -Requires 1 charge to
do a scan. Charges are generated each minute, holds up to 10<BR>&nbsp;
-Upgrade1 makes the scan also show information on the target,
including weapons<BR>&nbsp; -Upgrade2 makes the scan also show what
structures are near the target upon scan<BR>&nbsp; -It costs you $25
to use a scan<BR>&nbsp; </I><FONT COLOR="#ff0000"><I>-If
scan target has a scanner equipped, you will be scanned back. You
were warned.</FONT></I><BR><b>/buyspawnpoint</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$150&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sets
where you will spawn to your location<BR>&nbsp; <I>-Covering it with
a prop is the same as asking to be spawn camped<BR>&nbsp; -Buying
another spawn point will destroy the
original</I><BR><b>/buydispenser</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Press
use on it to get health and ammo<BR>&nbsp; <I>-Upgrade1 makes it give
ammo faster<BR>&nbsp; -Upgrade2 makes it also give
armor</I><BR><b>/buyrefinery</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drop
drugs into the refinery to make better drugs<BR>&nbsp; <I>-Requires 2
power to take in materials<BR>&nbsp; -Upgrade1 allows it to produce
randomdrugs out of less materials</I><BR>&nbsp; <I>-Upgrade2 allows
it to produce superdrugs out of randomdrugs and make drugs easier<BR>&nbsp;
-when fully upgraded, 3 booze = 1 drug. Unupgraded, 5 booze = 1
drug<BR>&nbsp; -when fully upgraded, produces 'randomdrug' with 5
drugs. Unupgraded takes 10 drugs<BR>&nbsp; -when fully upgraded,
produces superdrugs of the selected type with 10
randomdrugs</I><BR><b>/buygunlab</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Press
use on it to upgrade the gun you're
holding<BR><b>/buygunfactory</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$2000&nbsp;&nbsp;&nbsp;&nbsp;Creates
weapons that cannot normally be purchased<BR>&nbsp; <I>-Requires
3 power to make weapons<BR>&nbsp; -Upgrades allow it to produce more
types of weapons<BR>&nbsp; -Costs the owner of it $150 a minute to
make a weapon, costs anyone else $250 a
minute</I><BR><b>/buymicrowave</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Press
use to make food, which gives up to 125% health<BR>&nbsp; <I>-Requires
1 power to make food</I><BR><b>/buygunvault</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$300&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drop
guns into it to store them<BR><b>/buyairboat</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Buys
you an airboat<BR><b>/buypillbox</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$300&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drop
items into it to store them<BR>&nbsp; <I>-Pill box can store nearly
anything. health, drugs, booze, armor,
etc.</I><BR><BR><b>/buyplant <i>#</i></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Automatically
makes you $5 every minute<BR>&nbsp; <I>-Upon buying a plant, there is
a chance that it will be hemp, making $1 a minute
instead</I><BR><b>/buystill <i>#</i></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$250&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Automatically
makes you $10 every minute<BR>&nbsp; <I>-produces 'booze' item after
20 seconds</I><BR><b>/buydruglab <i>#</i></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Automatically
makes you $25 every minute<BR>&nbsp; <I>-produces 'drug' item after
20 seconds</I><BR><b>/buymethlab <i>#</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>$600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Automatically
makes you $50 every minute<BR>&nbsp; <I>-produces
'randomdrug' item after 60 seconds</I><BR>&nbsp;
-<I>Every minute, a methlab
has a 5% chance of randomly blowing up. Buy at own risk<BR>&nbsp;
-Chance of exploding is doubled if methlab is producing a
drug</I><BR><b>/buyprinter</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$1250&nbsp;&nbsp;&nbsp;&nbsp;Spawns
about $65 every minute&nbsp;<BR>&nbsp; <I>-Requires 1 power to
produce money</I><BR><BR><b>/upgrade</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upgrades
what you are looking at.<BR>&nbsp; <I>-First upgrade costs the same
as the object, second costs double.<BR>&nbsp; -All of the money
making structures make more money with
upgrades<BR></I><BR><b>/buyturret</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$300&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Buys
a sentry gun. Hold use on it to build it.<BR>&nbsp; <I>-Turret by
default will shoot at any player who isn't you once its built<BR>&nbsp;
-If you don't hold use on it to build it, it will not do anything.<BR>&nbsp;
-Don't use the turrets outside of your own base, it might get you
kicked.<BR>&nbsp; -using the turrets to kill everyone leaving spawn
will get you banned.<BR>&nbsp; -Sentry gun will spawn where you look,
even if its a wall or ceiling.<BR>&nbsp; -To make it not shoot
someone, both you and that person must check each others name<BR>&nbsp;
-Ally menu can be found in Options-&gt;WCARPDM-&gt;Allies in your
spawn menu ('Q' menu)<BR>&nbsp; </I><FONT COLOR="#ff0000"><I>-Sentry
gun </I><FONT COLOR="#ff0000"><I><b>CANNOT BE MOVED ONCE
SPAWNED</FONT></FONT></b></I>
</BODY>
]],[[
<body BGCOLOR=CCCCCC><FONT FACE="Courier New" SIZE=]]..tostring(tsize)..[[>
<b><h4>WCARPDM v2.0 (Modified from Darkrp 2.1a)</h4></b><br>
<u><h4>Other stuff</h4></u><br>
Anything that you can buy that is on this page come in packs of 5.<br>
<u>Command</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;<u>Duration</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>Description</u>
<h4><u><b>Special drugs</b></u></h4>
<br><u><b>Defense
drugs<br></b></u><br><b>/buyregen</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;120
seconds&nbsp;&nbsp;Heals health and armor over
time<br><b>/buypainkillers</b>&nbsp;$500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;140
seconds&nbsp;&nbsp;You take 1/3rd less
damage<br><b>/buyreflect</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$625&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;110
seconds&nbsp;&nbsp;1/3rd of damage you take hurts the attacker<br>&nbsp;
<I>-Does not work with knife, gas grenades, or poison
darts</I><br><b>/buyantidote</b>&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;150
seconds&nbsp;&nbsp;Poison and stun effects go away
faster<br><b>/buyadrenaline&nbsp;&nbsp;</b>$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;150
seconds&nbsp;&nbsp;Sets your max health to 150%<br>&nbsp; <I>-unlike
other items that give more than 100% health, this becomes your
default health</I><br><br><u><b>Offense
drugs<br></b></u><br><b>/buysteroids</b>&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;140
seconds&nbsp;&nbsp;You run faster<br><b>/buyamp</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;120
seconds&nbsp;&nbsp;You do 50% more
damage<br><b>/buydoublejump&nbsp;&nbsp;</b>$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;130
seconds&nbsp;&nbsp;Allows you to do a second jump while in
mid-air<br><b>/buyleech&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;140
seconds&nbsp;&nbsp;You absorb 1/3rd of the damage you do to players<br>&nbsp;
-Does not work with knife, gas grenades, or poison
darts<br><b>/buyarmorpiercer</b>$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;110
seconds&nbsp;&nbsp;You do 25% more damage to structures<br><br><u><b>Weapon
modifying drugs<br></b></u><SPAN STYLE="text-decoration: none">&nbsp;
<I>-None
of these work with HL2 weapons (except for
knockback)</I><u><b><br></b></u><br><b>/buyfocus</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;120
seconds&nbsp;&nbsp;Increased accuracy on weapons<br>&nbsp; <I>-Does
not work with grenade launcher, shotguns, or rocket launcher</I><br>&nbsp;
<I>-CSE weapons regain accuracy faster, other weapons have lower
spread</I><br><b>/buymagicbullet</b>&nbsp;$300&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;110
seconds&nbsp;&nbsp;Makes 50% of your shots hit a second player<br>&nbsp;
<I>-This will not work with
shotguns and weapons that don't fire bullets<br>&nbsp; -The second
person hit will take half the damage it did to the first player<br>&nbsp;
-Magic bullet will only work with bullets that actually hit a
player</I><br><b>/buyshockwave</b>&nbsp;&nbsp;&nbsp;$600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;130
seconds&nbsp;&nbsp;You fire explosive bullets<br>&nbsp;<I>
-Damage radius depends on the weapon<br>&nbsp; -This will have no
effect with weapons that don't fire
bullets</I><br><b>/buydoubletap</b>&nbsp;&nbsp;&nbsp;$750&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;120
seconds&nbsp;&nbsp;All of your weapons fire 35%
faster<br><b>/buyknockback</b>&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;110
seconds&nbsp;&nbsp;1/3rd of your shots will knock players back
<h4><u><b>Equipment</b></u></H4>
<br><br><b>/buyhealth</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$???&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Refills
health.<br>&nbsp; <I>-Price is $50 if there are no pharmacists, $250
if there are pharmacists.<br>&nbsp; -Can only be picked up 3 seconds
after it spawned</I><br><b>/buyarmor</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Provides
100 armor<br>
<b>/buyhelmet</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Makes headshots do 20% the damage of a body shot<br>
<b>/buyshield</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Survive
next damage that would kill you<br>&nbsp; <I>-as cheap as this is,
its probably a good idea to buy it the second you spawn<br>&nbsp; -if
you have this equipped, you CANNOT die from a single
hit</I><br><b>/buyscanner</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shows
enemy health, armor, and weapon
information<br><b>/buytoolkit</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pick
locks and defuse bombs faster<br><i>&nbsp; -also lets you use lockpick on keypads</i><br>
<H4><u><b>Other items</b></u></H4>
<br><br>You can't buy these
directly, they are created.<br><b>Drug</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-Drug
from a druglab. Gives 110% health<br><b>Booze</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-Booze
from a still. Gives 110% health<br><b>Food</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-Food
from a microwave. Gives 125% health<br><b>RandomDrug</b>&nbsp;&nbsp;-Made
from a refinery. Gives 1 random special drug effect<br><b>SuperDrug</b>&nbsp;&nbsp;&nbsp;-Made
from a fully upgraded refinery out of randomdrugs.<br>&nbsp; <I>-Gives
ALL special drug effects of its type with no overdose<br>&nbsp;
-There are 3 types of superdrugs, each giving the 5 of their type and
a random<br>&nbsp;  -Defense: regeneration, painkillers, antidote,
reflect, and adrenaline<br>&nbsp;  -Offense: steroids, double jump,
amplifier, leech, and armor piercer<br>&nbsp;  -Weaponmod: focus,
magic bullet, shockwave, double tap, and knockback<br>&nbsp; -All
superdrug given effects last 150 seconds</I><br><b>&Uuml;berDrug</b><I><b>&nbsp;&nbsp;&nbsp;&nbsp;</b></I>-Made
in a refinery out of SuperDrugs<br><FONT COLOR="#ff0000"><I>&nbsp;
-Gives EVERY SINGLE DRUG EFFECT OF ALL TYPES WITH NO OVERDOSE<br>&nbsp;
-This is the single best item in the entire game. It's effect is
nearly godmode</I><br><br><FONT COLOR="#000000">If you try to take too many
of the special drug effects, there is an increasing chance of having
an overdose, which poisons and kills you. Trying to take all 15 at
once is basically asking for it. SuperDrugs (and &Uuml;berDrugs) are
the only safe way to get all the effects at the same time. 
</body>
</font>
]]}















local function HelpNextPage()
	if currentpage<pages then
		currentpage=currentpage+1
		htmlbrick:SetHTML(helppages[currentpage])
		pagelbl:SetText("Page " .. currentpage .. " of " .. pages)
	end
end

local function HelpLastPage()
	if currentpage>1 then
		currentpage=currentpage-1
		htmlbrick:SetHTML(helppages[currentpage])
		pagelbl:SetText("Page " .. currentpage .. " of " .. pages)
	end
end

function MsgHelpMenu( msg )
	_GCloseAll = function(msg)
		if( HelpGUI ) then
			
			for k, v in pairs( HelpGUI ) do
				
				v:Remove();
				HelpGUI[k] = nil;
				
			end
			
		end
	end
	_GCloseAll()
	local panel = vgui.Create( "Frame" );
	panel:SetPos( 50 , 50 );
	panel:SetName( "Panel" );
	local pwidth = ScrW()-100
	local plength = ScrH()-100
	panel:LoadControlsFromString( [[
	
		"MainPanel"
		{
		
			"Panel"
			{
			
				"ControlName" "DPanel"
				"fieldName" "Help"
				"wide" ]] .. pwidth .. [[
				"tall" ]] .. plength .. [[
				"sizable" "0"
				"enabled" "1"
				"title" "WCARPDM Help"
			
			}
		
		}
	
	]] );
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( ScrW()-104, 2 );
	divider:SetVisible( true );
	/*_GNextPage = function( msg )
		HelpNextPage()
	end*/
	buttonNP = vgui.Create( "Button" );
		buttonNP:SetParent( panel );
		buttonNP:SetPos( pwidth-300, plength-40 )
		buttonNP:SetSize( 130, 28 );
		buttonNP:SetCommand( "!" );
		buttonNP:SetText( "Next Page" );
		buttonNP:SetActionFunction( HelpNextPage );
		buttonNP:SetVisible( true );	
	table.insert( HelpGUI, buttonNP );
	
	buttonPP = vgui.Create( "Button" );
		buttonPP:SetParent( panel );
		buttonPP:SetPos( pwidth-450, plength-40 )
		buttonPP:SetSize( 130, 28 );
		buttonPP:SetCommand( "!" );
		buttonPP:SetText( "Previous Page" );
		buttonPP:SetActionFunction( HelpLastPage );
		buttonPP:SetVisible( true );
	table.insert( HelpGUI, buttonPP );
	
	buttonCL = vgui.Create( "Button" );
		buttonCL:SetParent( panel );
		buttonCL:SetPos( pwidth-150, plength-40 )
		buttonCL:SetSize( 130, 28 );
		buttonCL:SetCommand( "!" );
		buttonCL:SetText( "Close Menu" );
		buttonCL:SetActionFunction( _GCloseAll );
		buttonCL:SetVisible( true );
	table.insert( HelpGUI, buttonCL );
	
	local label = vgui.Create( "HTML" );
		label:SetParent( panel );
		label:SetPos( 15, 45 );
		label:SetSize( pwidth-30, plength-85 );
		label:SetHTML( helppages[1] );
		label:SetVisible( true );
	table.insert( HelpGUI, label )
	htmlbrick = label
	
	local pagenum = vgui.Create( "Label" );
		pagenum:SetParent( panel );
		pagenum:SetPos( 10, plength-35 );
		pagenum:SetSize( 60, 14 );
		pagenum:SetText( "Page " .. currentpage .. " of " .. pages );
		pagenum:SetVisible( true );
	table.insert( HelpGUI, pagenum )
	pagelbl = pagenum
	
	currentpage=1
	PanelNumg = PanelNumg + 1;
	HelpGUI[PanelNumg] = panel;
end
//usermessage.Hook( "helpmenu", MsgHelpMenu );
usermessage.Hook( "ToggleHelp", MsgHelpMenu );
