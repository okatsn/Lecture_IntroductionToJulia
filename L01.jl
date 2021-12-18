### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ b51695fd-2fd1-490b-9095-c9d19878dd56
html"<button onclick='present()'>present</button>"
# for more info, see https://andreaskroepelin.de/blog/plutoslides/

# ╔═╡ 03f5e9bf-00e7-4a8d-bd73-d1f2316159f2
md"""
## 為何使用julia?
### 背景簡介(開發、目前運作)
### 優勢
- 很快、很簡單 “Walks like python, runs like C”
- 科學與數學計算方面的工具相當完整
### 劣勢
- 社群小、資產少(相對於python)
- 編譯時間長；在自動化腳本、網頁開發方面python會是較好的選擇
- 你的同事沒有在用


"""

# ╔═╡ bd19cf50-5fd9-11ec-0bc5-95352ec3ead8
md"""
# Julia 函式 (Functions)

在官方文件裡裡面，對於函式的定義是：”函式是一個將數組 (tuple) 引數 (argument) 對照到回傳值的物件”。也就是說，呼叫時是用數組的型態把引數傳遞給函式，函式內的運算結果再透過回傳值傳回。

我們可以透過函式的定義，將相同模式的動作或邏輯，抽象化提取出來成為可以重覆被呼叫使用的模塊。

可由以下方式建立函式：
```julia
function f(x, y)
    x + y
end
```
或
```julia
f(x, y) = x + y
```

也可使用匿名的方式建立([More info](https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions)):
```julia
f = (x, y) -> x + y
```
"""

# ╔═╡ e882362d-8db1-4570-a098-fd50f436f5c5
let
	f(x, y) = x + y;
	f(3, 2)
end

# ╔═╡ 0fd3158a-efc4-43c6-8061-9d925a13bd50
md"""
## 函式的變數作用域 (scope)
"""

# ╔═╡ 6586ce82-1cae-4de5-96c7-79f769dd5429
let
	a = 2;
	b = 3;
	function add_abcd(c,d)
	    a + b + c + d;
	end
	add_abcd(0.5,0.3)
end

# ╔═╡ Cell order:
# ╠═b51695fd-2fd1-490b-9095-c9d19878dd56
# ╟─03f5e9bf-00e7-4a8d-bd73-d1f2316159f2
# ╟─bd19cf50-5fd9-11ec-0bc5-95352ec3ead8
# ╠═e882362d-8db1-4570-a098-fd50f436f5c5
# ╠═0fd3158a-efc4-43c6-8061-9d925a13bd50
# ╠═6586ce82-1cae-4de5-96c7-79f769dd5429
