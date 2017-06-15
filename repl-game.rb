#!/usr/bin/env ruby
#
# repl-game.rb
# Copyright (C) 2017 Gregory Stula <gregstula.dev@icloud.com>
#
# Distributed under terms of the MIT license.
#

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end


BEASTIE_ASCII="
-.(`-')   (`-')  _  (`-')  _   (`-').-> (`-')        _       (`-')  _
 __( OO)   ( OO).-/  (OO ).-/   ( OO)_   ( OO).->    (_)      ( OO).-/
'-'---.\\  (,------.  / ,---.   (_)--\\_)  /    '._    ,-(`-') (,------.
| .-. (/   |  .---'  | \\ /`.\  /    _ /  |'--...__)  | ( OO)  |  .---'
| '-' `.) (|  '--.   '-'|_.' | \_..`--.  `--.  .--'  |  |  ) (|  '--.
| /`'.  |  |  .--'  (|  .-.  | .-._)   \    |  |    (|  |_/   |  .--'
| '--'  /  |  `---.  |  | |  | \       /    |  |     |  |'->  |  `---.
`------'   `------'  `--' `--'  `-----'     `--'     `--'     `------'


               /(        )`
               \\ \\___   / |
               /- _  `-/  '
              (/\\/ \\ \\   /\\
              / /   | `    \\
              O O   ) /    |
              `-^--'`<     '
             (_.)  _  )   /
              `.___/`    /
                `-----' /
   <----.     __ / __   \\
   <----|====O)))==) \\) /====|
   <----'    `--' `.__,' \\
                |        |
                 \\       /       /\\
            ______( (_  / \\______/
          ,'  ,-----'   |
          `--{__________)
"
BEASTIE_DESCR = "
The BSD daemon, nicknamed Beastie, is the generic mascot of BSD operating systems.
The BSD daemon is named after software daemons, a class of long-running computer programs in Unix-like operating
systems, which through a play on words takes the cartoon shape of a mythical demon. The BSD daemon's nickname Beastie
is a slurred phonetic pronunciation of BSD. Beastie customarily carries a trident to symbolize a software
daemon's forking of processes.
"

TUX_ASCII="

$$$$$$$$\\
\__$$  __|
   $$ |   $$\\   $$\\ $$\   $$\\
   $$ |   $$ |  $$ |\\$$\ $$  |
   $$ |   $$ |  $$ | \\$$$$  /
   $$ |   $$ |  $$ | $$  $$<
   $$ |   \\$$$$$$  |$$  /\$$\\
   \\__|    \\______/ \__/  \__|


                 .88888888:.
                88888888.88888.
              .8888888888888888.
              888888888888888888
              88' _`88'_  `88888
              88 88 88 88  88888
              88_88_::_88_:88888
              88:::,::,:::::8888
              88`:::::::::'`8888
             .88  `::::'    8:88.
            8888            `8:888.
          .8888'             `888888.
         .8888:..  .::.  ...:'8888888:.
        .8888.'     :'     `'::`88:88888
       .8888        '         `.888:8888.
      888:8         .           888:88888
    .888:88        .:           888:88888:
    8888888.       ::           88:888888
    `.::.888.      ::          .88888888
   .::::::.888.    ::         :::`8888'.:.
  ::::::::::.888   '         .::::::::::::
  ::::::::::::.8    '      .:8::::::::::::.
 .::::::::::::::.        .:888:::::::::::::
 :::::::::::::::88:.__..:88888:::::::::::'
  `'.:::::::::::88888888888.88:::::::::'
        `':::_:' -- '' -'-' `':_::::'`
"
TUX_DESCR = "
Tux is a penguin character and the official mascot of the Linux kernel. Originally created as an entry to a Linux
logo competition, Tux is the most commonly used icon for Linux, although different Linux distributions depict Tux
in various styles. The character is used in many other Linux programs and as a general symbol of Linux.
"

GNU_ASCII="
   _____   _   _   _    _
  / ____| | \\ | | | |  | |
 | |  __  |  \\| | | |  | |
 | | |_ | | . ` | | |  | |
 | |__| | | |\\  | | |__| |
  \\_____| |_| \\_|  \\____/



    _-`````-,           ,- '- .
  .'   .- - |          | - -.  `.
 /.'  /                     `.   \\
:/   :      _...   ..._      ``   :
::   :     /._ .`:'_.._\\.    ||   :
::    `._ ./  ,`  :    \\ . _.''   .
`:.      /   |  -.  \\-. \\\\_      /
  \\:._ _/  .'   .@)  \\@) ` `\\ ,.'
     _/,--'       .- .\\,-.`--`.
       ,'/''     (( \\ `  )
        /'/'  \\    `-'  (
         '/''  `._,-----'
          ''/'    .,---'
           ''/'      ;:
             ''/''  ''/
               ''/''/''
                 '/'/'
                  `;
"

GNU_DESCR = "
GNU is a recursive acronym for \"GNU's Not Unix!\" ,chosen because GNU's design is Unix-like, but differs from
Unix by being free software and containing no Unix code. The GNU project includes an operating system
kernel, GNU HURD, which was the original focus of the Free Software Foundation (FSF). However, non-GNU
kernels, most famously Linux, can also be used with GNU software; as the kernel is not yet production-ready, this
is how the GNU system is usually used.

The logo for GNU is a gnu head. Originally drawn by Etienne Suvasa, a bolder and simpler version designed by Aurelio
Heckert is now preferred.It appears in GNU software and in printed and electronic documentation for the
GNU Project, and is also used in Free Software Foundation materials.
"
class Character
	attr_reader(:ascii_art, :description, :happiness, :name)
	attr_writer(:happiness)

	def initialize(ascii, descr, name)
		@ascii_art = ascii
		@name = name
		@description = descr
		@happiness = 0
	end
end

beastie = Character.new(BEASTIE_ASCII, BEASTIE_DESCR, "Beastie")
tux = Character.new(TUX_ASCII, TUX_DESCR, "Tux")
gnu = Character.new(GNU_ASCII, GNU_DESCR, "Gnu")

character_list = [beastie, tux, gnu]
character_selected = nil

puts "Welcome to FOSS Explorer a simulation game where you simulate the exciting process of choosing a software license... also featuring classic open source mascots!"

puts
puts "Let's start!"


puts "You are a software developer working late at night in the comfort of your own home. You have just written an amazing
piece of FOSS (Free and Open Source Software) and you want to share it the world. The only problem is you are
struggling to pick an OSI approved software license "

puts
puts
puts "In the midsts of your struggles, three zany characters appear to assist you!"
puts '"Pick one of us to help guide you through your journey!", they say in unison.'
puts
puts "Options: 'List' (lists the characters) 'Quit' (quit the game early, this is getting too weird)"
options = gets.chomp

case options.downcase
when "list" then
	character_list.each do |char|
		puts "#{char.ascii_art}"
		puts "Select me? (Y/n)"
		yes_or_no = gets.chomp.downcase
		if yes_or_no == "y"
			character_selected = char
			break
		else
			next
		end
	end
when "quit" then
	exit(0)
end

unless character_selected.nil?
	puts "You have selected #{character_selected.name}"
  puts "Here is a short description: "
	puts "#{character_selected.description}"

	puts
	puts "SHABOOM! All of a sudden you are teleported to a ancient temple in the middle of an unkown jungle."
	puts "On the alter are 5 documents: The BSD 3-clause License, The BSD 2-Clause License, the GNU General Public License Version 2.0, the GNU General Public License Version 3.0, and the Apple iTunes Terms of Services agreement"

	puts
	puts "What do you do? (Options: 'Pick one up', 'Run away', 'Quit' )"
	options = gets.chomp
	case options.downcase
	when "pick one up" then
		puts
		puts "Which one do you pick up? (Options: 'BSD2', 'BSD3', 'GPL2', 'GPL3', 'Apple')"
		options = gets.chomp.downcase
		case options
		when "bds2" then
			if character_selected.name.downcase == "beastie"
				puts "#{green('Beastie liked that!')} Beastie's happiness increased by 2!"
				character_selected.happiness += 2
			elsif character_selected.name.downcase == "tux"
				puts "Tux disliked that! Tux's happiness decreased by 1!"
				character_selected.happiness -= 1
			elsif character_selected.name.downcase == "gnu"
				puts "GNU #{red('HATED')} that. GNU's happiness decreased by 5!"
				character_selected.happiness -= 5
			else
				puts "Something seriosuly went wrong... that's all we know"
				exit(1)
			end
		when "bsd3" then
			if character_selected.name.downcase == "beastie"
				puts "#{green('Beastie loved that!')} Beastie's happiness increased by 5!"
				character_selected.happiness += 5
			elsif character_selected.name.downcase == "tux"
				puts "Tux disliked that! Tux's happiness decreased by 1!"
				character_selected.happiness -= 1
			elsif character_selected.name.downcase == "gnu"
				puts "GNU #{red('HATED')} that. GNU's happiness decreased by 5!"
				character_selected.happiness -= 5
			else
				puts "Something seriosuly went wrong... that's all we know"
				exit(1)
			end
		when "gpl2" then
	 		if character_selected.name.downcase == "beastie"
				puts "#{red('Beastie was annoyed by that!')} Beastie's happiness decreased by 1!"
				character_selected.happiness -= 1
			elsif character_selected.name.downcase == "tux"
				puts "#{green('Tux LOVED that!')} Tux's happiness increased by 5!"
				character_selected.happiness += 5
			elsif character_selected.name.downcase == "gnu"
				puts "GNU was ok with that. GNU's happiness increased by 1!"
				character_selected.happiness += 1
			else
				puts "Something seriosuly went wrong... that's all we know"
				exit(1)
			end
		when "gpl3" then
			if character_selected.name.downcase == "beastie"
				puts "#{red('Beastie hated that!')} Beastie's happiness decreased by 5!"
				character_selected.happiness -= 5
			elsif character_selected.name.downcase == "tux"
				puts "Tux liked that! Tux's happiness increased by 1!"
				character_selected.happiness += 1
			elsif character_selected.name.downcase == "gnu"
				puts "GNU #{green('WAS OVER JOYED')} that. GNU's happiness increased by over 9000!"
				character_selected.happiness += 9001
			else
				puts "Something seriosuly went wrong... that's all we know"
				exit(1)
			end
		when "apple" then
			puts "Your mascot ran away abandoning you in the unkown jungle forever where you wandered for all eternity contemplating your actions."
			puts
			puts "GAME OVER!"
			exit(0)
		end
	when "run away" then
		puts "You foolishly ran away from the situation. Your mascot begged you to make a decision, but refused to follow you. You wander the unkown jungle for all eternity contemplating your actions"
		puts
		puts "GAME OVER!"
		exit(0)
	when "quit" then
		puts
		puts "GAME OVER!"
		exit(0)
	end


	def print_results(char)
		puts "#{red("Mascot: #{char.name}")}"
		puts "#{red("Happiness: #{char.happiness.to_s}")}"
		puts "CONGRATS!"
	end
	puts
	puts

	puts "With license in hand you decide you need to return home to apply it to your software. The only problem is that you're totally lost. What do you do? (Options: 'Ask the mascot', 'run away', 'smack the mascot','quit')"
	options = gets.chomp

	case options.downcase
	when "ask the mascot" then
	puts
	puts "You ask your mascot what to do."
	  if character_selected.name.downcase == "beastie"
	  	puts "Beastie says, \"I'm a daemon, with the power of running in the background. Also, I can teleport. I'll use the powers of teleportation to get us back home.\""
	  	puts
	  	puts "Ignoring the fact that his teleporation powers are the reason you are lost in the first place, you agree to use his powers as a means to get back home."
	  	puts
	  	puts "SHABOOM. You instantly arrive home safely in front of your computer. Ready to publish your work under an OSI approved license."
	  	puts
	  	print_results(character_selected)
	  elsif character_selected.name.downcase == "tux"
	  	puts "Tux says, \"I'm a kernal, with the power of controlling low level operating system processes. Also, I can teleport. I'll use the powers of teleportation to get us back home.\""
	  	puts
	  	puts "Ignoring the fact that his teleporation powers are the reason you are lost in the first place, you agree to use his powers as a means to get back home."
	  	puts
	  	puts "SHABOOM. You instantly arrive home safely in front of your computer. Ready to publish your work under an OSI approved license."
	  	puts
	  	print_results(character_selected)
	  elsif character_selected.name.downcase == "gnu"
	  	puts "Gnu says, \"I'm a collection of userland tools, with the power of controlling high level UNIX-like processes. Also, I can teleport. I'll use the powers of teleportation to get us back home.\""
	  	puts
	  	puts "Ignoring the fact that his teleporation powers are the reason you are lost in the first place, you agree to use his powers as a means to get back home."
	  	puts
	  	puts "SHABOOM. You instantly arrive home safely in front of your computer. Ready to publish your work under an OSI approved license."
	  	puts
	  	print_results(character_selected)
	  end
	when "run away" then
		puts "You foolishly ran away from the situation. Your mascot begged you not to and refused to follow you. You wander the unkown jungle for all eternity contemplating your actions"
		puts
		print_results(character_selected)
		puts "GAME OVER!"
		exit(0)
	when "smack the mascot" then
		puts "Your mascot screams in pain! He #{red('HATED')} that. Happiness was decreased by 5".
		character_selected.happiness -= 5
		puts "Your mascot ran away. But technically you finished the game so here are your stats: "
		print_results(character_selected)
	when "quit" then
		puts "GAME OVER!"
		print_results(character_selected)
		exit(0)
	end

else
	puts "You didn't select a character! Aborting...."
end