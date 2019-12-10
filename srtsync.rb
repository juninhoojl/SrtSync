#  !/usr/bin/ruby
#  Created by:
#  José Luiz Junior - @juninhoojl
#  SrtSync

require 'time'

if ARGV.length != 3
  puts "Not enough arguments to SrtSync\n\t<SubIn.srt> <±Milliseconds> <SubOut.srt>"
  exit(0)
end

arquivo = ARGV[0].to_s
ajuste = ARGV[1].to_f/1000
saida = ARGV[2].to_s
linhas = Array.new

File.foreach(arquivo) do |linha|
	if linha[8] == "," and linha[13] == "-" and linha[14] == "-" and linha[15] == ">"
		tempa = Time.parse(linha[0..11]) + ajuste
		tempb = Time.parse(linha[17..27]) + ajuste
		linha[0..11] = tempa.strftime("%H:%M:%S,%L")
		linha[17..28] = tempb.strftime("%H:%M:%S,%L")
	end
	linhas << linha.chomp
end

IO.write(saida, linhas.join("\n"))
