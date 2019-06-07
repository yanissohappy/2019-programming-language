# encoding: utf-8
import sys
import re
import urllib.request
import matplotlib.pyplot
import math

def removekey(d, key):
    r = dict(d)
    del r[key]
    return r

author_name = sys.stdin.readline()
author_name = author_name.strip() #完全地去除空白
print("Input Author: " + "[" + author_name + "]")
author_is_parsed_into_array = author_name.strip().split(' ')
author_for_lookup = "" #這會被當成要傳成url的作者!!!
if len(author_is_parsed_into_array) >= 2:
	for i in range(0, len(author_is_parsed_into_array)) :
		if i is 0:
			author_for_lookup = author_is_parsed_into_array[0]
			author_for_lookup = author_for_lookup.strip()
		else:	
			author_for_lookup = author_for_lookup + "+" + author_is_parsed_into_array[i]
else:
	author_for_lookup = author_is_parsed_into_array[0]
		
author_for_lookup = author_for_lookup.strip()
url = "https://arxiv.org/search/?query=" + str(author_for_lookup) + "&searchtype=author&abstracts=show&order=-announced_date_first&size=50"
content = urllib.request.urlopen(url)
html_str = content.read().decode("utf-8")

pattern_for_next_page = "pagination-list[\s\S]*?</ul>"
nextPage_array = re.findall(pattern_for_next_page, html_str)
print("[ Author: " + author_for_lookup + " ]")

if nextPage_array == [] : #如果沒有下一頁，就只要做單頁就好啦~
	pattarn = 'Authors:</span>[\s\S]*?</li>'
	result = re.findall(pattarn, html_str)
	paper_number_each_year = {}
	coauthor_common_paper = {}
	for r in result:
		name = r.split('</p>')[0].split('</a>')[:-1]

		author_name_array = []
		for n in name:
			tmp_Name = n.split('">')[1].strip()
			if tmp_Name.find("&#39;") != -1:
				tmp_Name = tmp_Name.replace("&#39;", "'") ##在這邊卡超級無敵久!!!原來是我阿呆，只有寫tmp_Name.replace而沒有給等號...(?)
			if tmp_Name is not ":":	
				author_name_array.append(tmp_Name)
			#print(tmp_Name)
		
	#print(author_name_array)
		
		pattarn_for_year = "originally announced</span>[\s\S]*?</p>"
		result = re.findall(pattarn_for_year, r)
		for r2 in result:
			year = r2.split('</span>')[1].split(".")[0].strip().split(" ")[1].strip()
			if year in paper_number_each_year:
				paper_number_each_year[year] = paper_number_each_year[year] + 1
			else:
				paper_number_each_year[year] = 1
				
		for name_author in author_name_array:
			if name_author in coauthor_common_paper:
				coauthor_common_paper[name_author] = coauthor_common_paper[name_author] + 1
			else:
				coauthor_common_paper[name_author] = 1
	Ans = removekey(coauthor_common_paper, author_name)			
	sorted_coauthor_common_paper = sorted(Ans)
	for data in sorted_coauthor_common_paper:
		print("[" + data + "]: " + str(Ans[data]) + " times")	
	matplotlib.pyplot.bar(sorted(paper_number_each_year.keys()), paper_number_each_year.values(), width = 0.8, align="center", facecolor = 'lightskyblue', edgecolor = 'white')	
	matplotlib.pyplot.show()			
else: #很悲慘地，如果有下一頁的話(那就要開始運算下一頁及下下一頁....etc(if any)的網址，並存成array)
	pattarn_for_title = 'Showing 1&ndash;[\s\S]*? results'
	result_for_title = re.findall(pattarn_for_title, html_str)
	for r in result_for_title:
		temp_number = r.split('Showing')[1].split(' ')[3].strip()	
	number_without_comma_in_array = temp_number.split(',')#因為有可能是千位數，而千位數的表示方式是5,000(舉例)所以要把逗號弄掉並整合
	number = "".join(number_without_comma_in_array)
	number = number.strip()
	#print(number)

	total_search_page = math.ceil((int(number)+1)/50) 
	total_url=[]
	for i in range(0,total_search_page):
		total_url.append(url+"&start="+ str(i*50)) #記錄所有的網址(利用把基底黏上去的方式)
	#print(total_search_page)

	paper_number_each_year = {}
	coauthor_common_paper = {}	
	for index_url in total_url:	
		content = urllib.request.urlopen(index_url)
		html_str = content.read().decode("utf-8")

		pattarn = 'Authors:</span>[\s\S]*?</li>'
		result = re.findall(pattarn, html_str)
		for r in result:
			name = r.split('</p>')[0].split('</a>')[:-1]

			author_name_array = []
			for n in name:
				tmp_Name = n.split('">')[1].strip()
				if tmp_Name.find("&#39;") != -1:
					tmp_Name = tmp_Name.replace("&#39;", "'")
				if tmp_Name is not ":":
					author_name_array.append(tmp_Name)
			
			pattarn_for_year = "originally announced</span>[\s\S]*?</p>"
			result = re.findall(pattarn_for_year, r)
			for r2 in result:
				year = r2.split('</span>')[1].split(".")[0].strip().split(" ")[1].strip()
				if year in paper_number_each_year:
					paper_number_each_year[year] = paper_number_each_year[year] + 1
				else:
					paper_number_each_year[year] = 1
					
			for name_author in author_name_array:
				if name_author in coauthor_common_paper:
					coauthor_common_paper[name_author] = coauthor_common_paper[name_author] + 1
				else:
					coauthor_common_paper[name_author] = 1
					
	Ans = removekey(coauthor_common_paper, author_name)				
	sorted_coauthor_common_paper = sorted(Ans)	
	for data in sorted_coauthor_common_paper:
		print("[" + data + "]: " + str(Ans[data]) + " times")	
	matplotlib.pyplot.bar(sorted(paper_number_each_year.keys()), paper_number_each_year.values(), width = 0.8, align="center", facecolor = 'lightskyblue', edgecolor = 'white')	
	matplotlib.pyplot.show()