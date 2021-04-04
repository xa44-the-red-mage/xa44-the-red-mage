pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

objects = {}

menu = 0

playerwalk = 0
encheck = 0
encheck1 = 1
expcheck = 1

x = 0
y = 0

menudel = 0
cur = 1
submenu = 0

partysize = 1

mp = 6
maxmp = 8

plv = 1
pexp = 0
pmaxhp = 10
php = 10
patk = 5
pdef = 5
pspeed = 2
pstatus = 1

chr1 = -1
chr1c = 1
alv = 1
aexp = 0
amaxhp = 5
ahp = 5
aatk = 2
adef = 2
aspeed = 1

ehp1 = 0
eatk1 = 0
edef1 = 0
espeed1 = 0
estatus1 = 0

encnumb = 0

turncount = 2


dmg = 0
dmg1 = 0


test = 0
function _init()
	player = newobj(30,75,5,5,1,0,0)
	add(objects,player)
	
	x = 2
	y = 2
end


function _update()
	for o in all(objects) do
		o:update()
	end
	--character check
	if chr1 >= 0 then
		if chr1c == 1 then
			chr1 = 1
			partysize = partysize + 1
			chr1c = 0
		end
	end
	if menu == 0 then
	turncount = 2
	-- normal movement
		if playerwalk == 0 then
			playerwalk = 2
			player.sprt = 17
		elseif playerwalk == 2 then
			playerwalk = 3
		elseif playerwalk == 3 then
			playerwalk = 4
		elseif playerwalk == 4 then
			playerwalk = 5
		elseif playerwalk == 5 then
			playerwalk = 6
		elseif playerwalk == 6 then
			playerwalk = 7
		elseif playerwalk == 7 then
			playerwalk = 8
		elseif playerwalk == 8 then
			playerwalk = 1
		elseif playerwalk == 1 then
			playerwalk = -1
			player.sprt = 1
		elseif playerwalk == -1 then
			playerwalk = -2
		elseif playerwalk == -2 then
			playerwalk = 0
		end
	
		if btn(1,0) then
			player.x = player.x + 1.3
			encheck = 1
		end
		if btn(0,0) then
			player.x = player.x - 1.3
			encheck = 1
		end
		if btn(3,0) then
			player.y = player.y + 1.3
			encheck = 1
		end
		if btn(2,0) then
			player.y = player.y - 1.3
			encheck = 1
		end
		
		
		if x == 1 then
			if player.x <= 6 then
				player.x = 6
			end
		end
		if y == 1 then
			if player.y <= 7 then
				player.y = 7
			end
		end
		if x == 3 then
			if player.x >= 114 then
				player.x = 114
			end
		end
		if y == 3 then
			if player.y >= 112 then
				player.y = 112
			end
		end
		
		--screen movement
		if player.x >= 128 then
			player.x = 3
			x = x+1
		end
		if player.y >= 128 then
			player.y = 3
			y = y+1
		end
		
		if player.x <= 0 then
			player.x = 125
			x = x-1
		end
		if player.y <= 0 then
			player.y = 125
			y = y-1
		end
		--opening menu
		if btn(4,0) then
			if menudel == 0 then
				menu = 1
				menudel = 5
			end
		end
		--interactables
		if x == 1 then
			if y == 1 then
				if chr1 == -1 then
					if player.x >= 62 then
						if player.x <= 84 then
							if player.y >= 62 then
								if player.y <= 84 then
									if btn(5,0) then
										chr1 = 1
									end
								end
							end
						end
					end
				end
			end
		end

		--random encounter check
		if encheck == 1 then
			get = flr(rnd(100))
			if x == 3 then
				if y == 3 then
					if get <= 3 then
						encnumb = 1
						menu = 2
						encheck = 0
					end
				end
			end
		end
	end
	
	if menu == 1 then
	expcheck = 1
		--basic menu
			if menudel == 0 then
				if btn(2,0) then
					cur = cur - 1
					menudel = 5
				end
				if btn(3,0) then
					cur = cur + 1
					menudel = 5
				end
				if submenu == 2 then
					if cur == 0 then
						cur = partysize
					end
					if cur == (partysize + 1) then
						cur = 1
					end
				end
				if cur == 0 then
					cur = 5
				end
				if cur == 6 then
					cur = 1
				end
				if submenu == 2 then
					if cur == 0 then
						cur = partysize
					end
					if cur == (partysize + 1) then
						cur = 1
					end
				end
				if menudel == 0 then
					if submenu == 0 then
						if btn(5,0) then
							if cur == 1 then
								submenu = 1
							end
							if cur == 2 then
								submenu = 2
							end
							if cur == 3 then
								submenu = 3
							end
							if cur == 4 then
								submenu = 4
							end
							if cur == 5 then
								submenu = 5
							end
							cur = 1
							menudel = 5
						end
					end
				end
				--resting
				if submenu == 5 then
					php = pmaxhp
					mp = maxmp
					if chr1 >= 0 then
						ahp = amaxhp
						if btn(4,0) then
							if cur == 1 then
								chr1 = -2
								partysize = partysize - 1
								pmaxhp = pmaxhp + 2
								patk = patk + 1
								pdef = pdef + 1
							end
							if cur == 2 then
								menu = 0
								menudel = 5
								cur = 1
								submenu = 0
							end
						end
					end
				end
			end
		--close menu
		if btn(4,0) then
			if menudel == 0 then
				menu = 0
				menudel = 5
				cur = 1
				submenu = 0
			end
		end
	end
	
	if menu == 2 then
		--encounter stats
		if encnumb == 1 then
			if encheck1 == 1 then
				ehp1 = 3
				eatk1 = 3
				edef1 = 3
				espeed1 = 3
				estatus1 = 3
				encheck1 = 0
			end
		end
		
		--battle phases
		if menudel == 0 then
			if cur == 1 then
				if submenu == 0 then
					if btn(4,0) then
						submenu = 1
						menudel = 5
					end
				end
			end
			if submenu == 0 then
				if btn(2,0) then
					cur = cur - 1
					menudel = 5
				end
				if btn(3,0) then
					cur = cur + 1
					menudel = 5
				end
				if submenu == 2 then
					if cur == 0 then
						cur = partysize
					end
					if cur == (partysize + 1) then
						cur = 1
					end
				end
				if cur == 0 then
					cur = 4
				end
				if cur == 5 then
					cur = 1
				end
			end
			--focus
			if cur == 3 then
				if btn(4,0) then
					if menudel == 0 then
						mp = mp + 1
						menudel = 5
						cur = 1
						if mp > maxmp then
							 mp = maxmp
						end
						turncount = turncount - 1
					end
				end
			end
			
			--attacking
			if cur == 1 then
				if submenu == 1 then
					if menudel == 0 then
						if btn(4,0) then
							if turncount == 2 then
								dmg = flr(patk/3*(0.9 + rnd(0.20) )-edef1/3*(0.45 + rnd(0.15)))
								if dmg < 1 then
									dmg = 1
								end
								ehp1 = ehp1 - dmg
							end
							if turncount == 1 then
								dmg = flr(aatk/3*(0.9 + rnd(0.20) )-edef1/3*(0.45 + rnd(0.15)))
								if dmg < 1 then
									dmg = 1
								end
								ehp1 = ehp1 - dmg
							end
							turncount = turncount - 1
							menudel = 5
							submenu = 0
						end
					end
				end
			end
			--spells option
			if submenu == 0 then
				if cur == 2 then
					if menudel == 0 then
						if btn(4,0) then
							submenu = 10
							menudel = 5
						end
					end
				end
			end
			--spell select
			if submenu == 10 then
				if menudel == 0 then
					if btn(2,0) then
						cur = cur - 1
						menudel = 5
					end
					if btn(3,0) then
						cur = cur + 1
						menudel = 5
					end
					if cur >= 5 then
						cur = 1
					end
					if cur <= 0 then
						cur = 4
					end
					if btn(4,0) then
						--spell fire
						if turncount == 2 then
						--power hit
							if mp >= 2 then
								if cur == 1 then
									if submenu == 10 then
										if menudel == 0 then
											if turncount == 2 then
												dmg = flr(1.6*patk/3*(0.9 + rnd(0.20) )-edef1/3*(0.45 + rnd(0.15)))
												if dmg < 1 then
													dmg = 1
												end
												ehp1 = ehp1 - dmg
											end
											mp = mp - 2
											turncount = turncount - 1
											menudel = 5
											submenu = 0
											cur = 1
										end
									end
								end
							end
							--mega heal
							if mp >= 4 then
								if chr1 == -2 then
									if cur == 2 then
										php = php + 10
										if php > pmaxhp then
											php = pmaxhp
										end
										mp = mp - 4
										turncount = turncount - 1
										menudel = 5
										submenu = 0
										cur = 1
									end
								end
							end
						end
							
						if turncount == 1 then
						--heal
							if mp >= 2 then
								if cur == 1 then
									php = php + 1
									ahp = ahp + 1
									if php > pmaxhp then
										php = pmaxhp
									end
									if ahp > amaxhp then
										ahp = amaxhp
									end
									mp = mp - 1
									turncount = turncount - 1
									menudel = 5
									submenu = 0
									cur = 1
								end
							end
						end
						if btn(5,0) then
							submenu = 0
							menudel = 5
							cur = 1
						end
					end
				end
			end
			--turn count stuff
			if turncount == 1 then
				if chr1 >= 1 then
					
				elseif chr1 <= 0 then
					turncount = turncount - 1
				end
			end
			if turncount == 0 then
				etartget = flr(rnd(partysize+0.99))
				if etartget == 1 then
					dmg1 = flr(eatk1/3*(0.9 + rnd(0.20) )-pdef/3*(0.45 + rnd(0.15)))
					if dmg1 < 1 then
						dmg1 = 1
					end
				php = php - dmg1
				end
				if etartget == 2 then
					dmg1 = flr(eatk1/3*(0.9 + rnd(0.20) )-adef/3*(0.45 + rnd(0.15)))
					if dmg1 < 1 then
						dmg1 = 1
					end
				ahp = ahp - dmg1
				end
				turncount = 2
			end
		end
		--end of battle
		if ehp1 <= 0 then
			if expcheck == 1 then
				pexp = pexp + 50
				expcheck = 0
				if chr1 >= 0 then
					aexp = aexp + 50
				end
			end
			menu = 0
			encnumb = 0
			cur = 1
			submenu = 0
			encheck = 0
			encheck1 = 1
		end
	end
	
	--leveling
	if pexp >=100 then
		pexp = pexp - 100
		plv = plv + 1
		pmaxhp = pmaxhp + flr(rnd(6))
		php = pmaxhp
		patk = patk + flr(rnd(3)+0.5)
		pdef = pdef + flr(rnd(3))
	end
	
	if aexp >= 100 then
		aexp = aexp - 100
		alv = alv + 1
		amaxhp = amaxhp + flr(rnd(5)) + 1
		ahp = amaxhp
		aatk = aatk + flr(rnd(2))
		adef = aatk + flr(rnd(2))
	end
	
	--menu delley
	if menudel != 0 then
		menudel = menudel -1
	end
	
	--statuss
	if php == 0 then
		pstatus = 0
	end
	if php < 0 then
		php = 0
	end
	if chr1 >= 0 then
		if ahp == 0 then
			chr1 = 0
		end
		if ahp < 0 then
			ahp = 0
		end
	end

end


function _draw()
	cls(0)
	if test == 1 then
		print("everything went very poorly",7,7,7)
	end
	if menu == 0 then
	--what map is drawn and what to draw
		if x == 2 then
			if y == 2 then
				for k  = 0,16 do
					for l = 0,16 do
						spr(0,k*8,l*8)
					end
				end
			end
		end
		if x == 3 then
			if y == 2 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,15*8,j*8)
					spr(32,14*8,j*8)
				end
			end
		end
		if x == 2 then
			if y == 3 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,j*8,15*8)
					spr(32,j*8,14*8)
				end
			end
		end
		if x == 1 then
			if y == 2 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,0,j*8)
					spr(32,8,j*8)
				end
			end
		end
		if x == 2 then
			if y == 1 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,j*8,0)
					spr(32,j*8,8)
				end
			end
		end	
		if x == 1 then
			if y == 1 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,j*8,0)
					spr(32,j*8,8)
					spr(16,0,j*8)
					spr(32,8,j*8)
				end
				if chr1 == -1 then
					spr(2,70,70)
				end
			end
		end
		if x == 3 then
			if y == 1 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(32,j*8,8)
					spr(32,112,j*8)
					spr(16,120,j*8)
					spr(16,j*8,0)
				end
				spr(16,120,8)
			end
		end	
		if x == 1 then
			if y == 3 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,j*8,120)
					spr(32,j*8,112)
					spr(16,0,j*8)
					spr(32,8,j*8)
				end
				spr(16,8,120)
			end
		end
		if x == 3 then
			if y == 3 then
				for k  = 0,15 do
					for l = 0,15 do
						spr(0,k*8,l*8)
					end
				end
				for j = 0,15 do
					spr(16,j*8,120)
					spr(32,j*8,112)
					spr(16,120,j*8)
					spr(32,112,j*8)
				end
				spr(16,120,112)
				spr(16,112,120)
			end
		end
		for o in all(objects) do
			o:draw()
		end
	end

	if menu == 1 then
	--basic menu
		print("equipment",5,10,6)
		if submenu == 0 then
			if cur == 1 then
				spr(48,1,10)
			end
		end
		print("stats",5,18,7)
		if submenu == 0 then
			if cur == 2 then
				spr(48,1,18)
			end
		end
		print("items",5,26,7)
		if submenu == 0 then
			if cur == 3 then
				spr(48,1,26)
			end
		end
		print(" ",5,34,6)
		if submenu == 0 then
			if cur == 4 then
				spr(48,1,34)
			end
		end
		print("rest",5,42,7)
		if submenu == 0 then
			if cur == 5 then
				spr(48,1,42)
			end
		end
		
		print("man",80,20,7)
		spr(1,70,18)
		if chr1 >= 0 then
			print("woman",80,29,7)
			spr(2,70,27)
		end
		
		--sub menus
		if submenu == 1 then
		
		end
		if submenu == 2 then
			if cur == 1 then
				spr(48,67,20)
				--level
				print("lv",70,90)
				print(plv,80,90)
				print("epx",98,90)
				print(pexp,113,90)
				--stats
				print("hp",70,100)
				print(php,80,100)
				print("/",100,100)
				print(pmaxhp,110,100)
				print("atk",70,110)
				print(patk,83,110)
				print("def",70,120)
				print(pdef,83,120)
				print("spd",100,110)
				print(pspeed,113,110)
				
				--statuss
				if pstatus == 1 then
					print("ok",100,120)
				end
				if pstatus == 0 then
					print("ko",100,120)
				end
				if pstatus == 2 then
					print("psn",100,120)
				end
			end
			
			if cur == 2 then
				if chr1 >= 0 then
					spr(48,67,29)
					--level
					print("lv",70,90)
					print(alv,80,90)
					print("epx",98,90)
					print(aexp,113,90)
					--stats
					print("hp",70,100)
					print(ahp,80,100)
					print("/",100,100)
					print(amaxhp,110,100)
					print("atk",70,110)
					print(aatk,83,110)
					print("def",70,120)
					print(adef,83,120)
					print("spd",100,110)
					print(aspeed,113,110)
					
					--statuss
					if chr1 == 1 then
						print("ok",100,120)
					end
					if chr1 == 0 then
						print("ko",100,120)
					end
					if chr1 == 2 then
						print("psn",100,120)
					end
				end
			end
			
			if cur == 1 then
				print("2 - power hit",10,70,7)
				if chr1 == -2 then
					print("4 - mega heal",10,80,7)
				end
				--print("spell3",10,90,7)
				--print("spell4",10,100,7)
			end
			if cur == 2 then
				print("2 - heal",10,70,7)
				--print("spell2",10,80,7)
				--print("spell3",10,90,7)
				--print("spell4",10,100,7)
			end
			
			
		end
		if submenu == 3 then
			
		end
		if submenu == 4 then
		
		end
		if submenu == 5 then
			if chr1 >= 0 then
				print("eat?",70,70,8)
				print("yes",60,80,8)
				print("no",80,80,8)
				if cur == 1 then
					spr(48,55,80)
				end
				if cur == 2 then
					spr(48,75,80)
				end
			end
		end
	end
	
	if menu == 2 then
	--hud
	print("player delt",3,3,7)
	print(dmg,50,3,7)
	print("enemy delt",3,11,7)
	print(dmg1,45,11,7)
	--menus
		if submenu == 0 then
			print("attack",10,70,7)
			if cur == 1 then
				spr(48,5,70)
			end
			print("spells",10,80,7)
			if cur == 2 then
				spr(48,5,80)
			end
			print("focus",10,90,7)
			if cur == 3 then
				spr(48,5,90)
			end
			print("item",10,100,7)
			if cur == 4 then
				spr(48,5,100)
			end
		end
		--spell menu
		if submenu == 10 then
			if turncount == 2 then
				print("2 - power hit",10,70,7)
				if cur == 1 then
					spr(48,5,70)
				end
				if chr1 == -2 then
					print("4 - mega heal",10,80,7)
				end
				if cur == 2 then
					spr(48,5,80)
				end
				--print("spell3",10,90,7)
				if cur == 3 then
					spr(48,5,90)
				end
				--print("spell4",10,100,7)
				if cur == 4 then
					spr(48,5,100)
				end
			end
			if turncount == 1 then
				print("2 - heal",10,70,7)
				if cur == 1 then
					spr(48,5,70)
				end
				--print("spell2",10,80,7)
				if cur == 2 then
					spr(48,5,80)
				end
				--print("spell3",10,90,7)
				if cur == 3 then
					spr(48,5,90)
				end
				--print("spell4",10,100,7)
				if cur == 4 then
					spr(48,5,100)
				end
			end
		end
		
	--hp hud
	spr(1,70,68)
	print(php,77,70)
	print("/",97,70)
	print(pmaxhp,102,70)
	
	line(7,60,7,60-maxmp*3,8)
	line(5,60,5,60-maxmp*3,8)
	line(6,60,6,60-maxmp*3,8)
	line(5,60,5,60-mp*3,12)
	line(6,60,6,60-mp*3,12)
	line(7,60,7,60-mp*3,12)
	
	
	if turncount == 2 then
		spr(48,67,71)
	end
	
	if chr1 >= 0 then
		spr(2,70,78)
		print(ahp,77,80,7)
		print("/",97,80,7)
		print(amaxhp,102,80,7)
		if turncount == 1 then
			spr(48,67,81)
		end
	end
	
	--encounter formation
		if encnumb == 1 then
			if ehp1 > 0 then
				spr(33,40,40)
				if submenu == 1 then
					spr(48,35,40)
				end
			end
		end
		
		
		--close menu
		
		if btn(5,0) then
			if menudel == 0 then
				submenu = 0
				cur = 1
			end
		end
	end

end

function drawobj(o)
	if o.vis == 1 then
		spr(o.sprt,o.x,o.y,1,1,o.flip) 
	end	
end

function moveobj(o)
	o.x = o.x + sin(o.dir/360) * o.spd
	o.y = o.y - cos(o.dir/360) * o.spd
end

function updateobj(o)
	moveobj(o)
end



function newobj(x,y,w,h,sprt,spd,dir,vis,flip,type)
	local o = {}
	o.x = x; o.y=y; o.w=w;o.h=h
	o.sprt = sprt
	o.spd = spd
	o.dir = dir or 0
	o.vis = vis or 1
	o.flip = flip or false
	o.type = type or 0
	o.destroy = false
	o.update = updateobj
	o.draw = drawobj
	return o
end

function recthit(r1,r2)
	if (ptinrect(r1.x,r1.y,r2)) return true
	if (ptinrect(r1.x+r1.w,r1.y,r2)) return true
	if (ptinrect(r1.x,r1.y+r1.h,r2)) return true
	if (ptinrect(r1.x+r1.w,r1.y+r1.h,r2)) return true
	
	if (ptinrect(r2.x,r2.y,r1)) return true
	if (ptinrect(r2.x+r2.w,r2.y,r1)) return true
	if (ptinrect(r2.x,r2.y+r2.h,r1)) return true
	if (ptinrect(r2.x+r2.w,r2.y+r2.h,r1)) return true
	
	return false
end

function ptinrect(x,y,r)
	if x >= r.x and x <= r.x + r.w then
		if y >= r.y and y <= r.y + r.h then
			return true
		end
	end
	return false
end




__gfx__
333b333300022000000ee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333b33330024440000888e0000111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333333330444ff00028ff8e0011ff110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333333b3009ff90008cffc80014ff410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33b33b3300ffff0008ffff8011ffff11000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b333b3300888800089aa98000666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb33333008888000277772000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333008008000072270000500500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111002220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11cc1111022444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cc111111044fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111cc1009ff9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111cc11100ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11cc1111008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111cc11000280000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffff7f000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f7ffffff006cc6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fffff7ff0dcc7c600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ff7fffffdcccc7c60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffdcccc7c60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f7ffff7fdccccccd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffff7fff0dccccd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff00dddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
82000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
