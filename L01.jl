### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ 7b6611e9-e9fe-425b-ba66-1454218bbfb4
begin
	using PlutoUI
	using BenchmarkTools
	using LaTeXStrings

end

# ╔═╡ b51695fd-2fd1-490b-9095-c9d19878dd56
html"<button onclick='present()'>present</button>"
# for more info, see https://andreaskroepelin.de/blog/plutoslides/

# ╔═╡ d34e2dae-735a-4fd9-9958-af58e04c4ca9

TableOfContents(title="📚 Table of Contents", indent=true, depth=4, aside=false)

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

# ╔═╡ e68b0d87-d103-4618-8fa6-ad34104cb8f8
md"""
### The speed of julia
![](https://github.com/okatsn/Lecture_IntroductionToJulia/raw/master/image/fig_JuliaSpeed.png)
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
## 函式的變數作用域 (Scope of Variable)
變數作用域 (Scope of Variable)指的是變數可以被"看到"的執行層面。
[官方文件之詳細說明](https://docs.julialang.org/en/v1/manual/variables-and-scoping/index.html)。
函式的變數作用域跟 `for` 迴圈很類似，在 `function ... end` 區塊中才第一次被創建的變數，在區塊外面都不會被"看到"。
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

# ╔═╡ ebb7d6f1-af95-43e7-9581-5e6b9777fe39
md"""
## 多重分派 (Multiple dispatch)
[(for more info, see this)](https://yuehhua.github.io/2020/04/01/julia-multiple-dispatch/)

多重分派是julia最明顯的特色。 多重分派指的是
另一方面， 在單一分派的物件導向程式設計中，我們會將函式(function)歸類到某個類別(class)底下的方法(method)。 以下是 python的範例程式碼：
```python
# 定義函式
class Foo:
    def abc(self, x):
        return str(x)

class Bar:
    def abc(self, x):
        return int(x)

# 建立物件
foo = Foo()
bar = Bar()

# 呼叫函式：
foo.abc()
bar.abc()
```
"""

# ╔═╡ 621fec83-b164-4988-9841-3f4622a6139f
md"""
## 從實例認識多重分派：
"""

# ╔═╡ 61acc7f6-1320-415a-9614-db079f35228b
L"""

\underbrace{切割}_{方法}\underbrace{木頭}_{物件}
"""

# ╔═╡ fae01d58-aabb-4822-ad2f-c308e1386969
md"""
建立一個🪵(木頭)的類別
"""

# ╔═╡ 9291dbf9-d772-4ead-82ba-156fdecb172d
mutable struct 🪵 # 類別: 木頭
	A::Float64 # 截面積
	L::Float64 # 長度
end

# ╔═╡ 49a02781-7b9a-4f57-b0ed-992d6d8ae2f1
md"建立一個類別屬於🪵的物件實體："

# ╔═╡ 6cabd377-ad4f-4ead-b36c-36ad9a5a7b73
wood1 = 🪵(5, 70)

# ╔═╡ d1f9dedf-aba4-48d8-935f-eda0092ea8cf
md"""
創建一個方法🪓把木頭🪵砍半：
"""

# ╔═╡ f3697ee8-7de1-4698-804d-101e15da89fb
function 🪓(w::🪵)
	w.L=w.L/2
	(w, w)
end

# ╔═╡ 80d895ca-4d8c-4ca3-8c76-02c09f6d7836
md"(`::` is type assertion. For example, `A::Float64` returns nothing if `A` is a floating number of 64bit; otherwise, an error will be raised.)"

# ╔═╡ 1b3462ed-fa28-48e1-a3dd-14263f399b6b
md"如果我想把木頭切成n等分? "

# ╔═╡ aa730d31-0e37-4ac8-9b23-a443314af322
function 🪓(w::🪵, n)
	w.L=w.L/n;
	fill(w, n)
end

# ╔═╡ 11001bc8-865a-42e9-91b3-57a77211d108
md"""
🪓還可以拿來砍別的東西吧? 如果我想要把一個向量砍半的話...
"""

# ╔═╡ 8d10e00d-a439-479a-8c56-d7923d2a39d5
function 🪓(vec::Vector)
	lenv = length(vec); 
	mid = Int(lenv/2); # "中間"定義為向量長度的一半向下取整數
	return (vec[1:mid], vec[mid+1:end])
end

# ╔═╡ 0e835f9d-b45b-4063-add9-e853c85d45f5
🪓(wood1)

# ╔═╡ 00aaa76e-92e8-420a-b06f-391806339f8b
let 
	wood2 = 🪵(5, 70)
	🪓(wood2, 5)
end

# ╔═╡ d45e0f9d-8fce-4f48-96c3-078d8098666e
let
v = [1,2,3,4,5,6,7,8,9,10];
🪓(v)
end

# ╔═╡ 18da0620-5ef9-4b56-9598-345230edb1d7
md"""
## 從 julia 內建的乘法看多重分派
"""

# ╔═╡ d017a18a-727f-440d-b42e-97e40e1dc6a1
md"實數乘法："

# ╔═╡ 2dc59144-3bae-4f9a-a3e7-cf6a82a27802
md"虛數乘法："

# ╔═╡ 88910e9c-a8c3-47d6-948e-c646e72fc180
md"矩陣乘法："

# ╔═╡ 161117db-6ccd-4056-8353-05aa64f6ce71
L"""
\begin{pmatrix}
1 & 2 \\
3 & 4
\end{pmatrix}

\begin{pmatrix}
3 & 1 \\
0 & 2
\end{pmatrix}

= 

\begin{pmatrix}
3 & 5 \\
9 & 11
\end{pmatrix}
"""

# ╔═╡ 95611b36-5370-4b13-a1f0-4f8fdbfb0f3d
md"字串相乘?"

# ╔═╡ c287f471-ecea-4671-90d3-5dd6439f4846
md"""
### 擴充乘法
一般來說， `3*"Hello"` 是會報錯的，因為不存在方法支援整數(Int)與字串(String)的相乘:
```julia:repl
ERROR: MethodError: no method matching *(::Int64, ::String)
```

julia 的操作運算子也都是函式， 例如， `3*2` 其實也可以寫成 `*(3,2)`。
julia 內建的函式都放在 Base 下面。
利用多重分派， 我們可以新增乘法符號的新方法， 使得 `3*"Hello"` 得到 `"HHHeeellllllooo"`：
"""

# ╔═╡ 77b1d882-c45b-4889-8785-09d8b412b102
function Base.:*(n::Int, str::String) # :* 代表乘法(*)的符號，其類別是 Symbol
	str1 = [];
	for s in str
		for i = 1:n
			push!(str1, s)
		end
	end
	return string(str1...)
end

# ╔═╡ 88d9f535-bf29-490a-be26-0c3bd63e7231
110*55

# ╔═╡ 47b9aba5-054b-46dc-bdf4-fac7c147f60b
(1+1im)*(1+1im)

# ╔═╡ 5ee4dfff-ca59-43aa-96cd-2379dbff5e5f
[1 2; 3 4]*[3 1; 0 2]

# ╔═╡ 01d91380-e44e-4d77-93bb-329ce2de20b3
"hello"*"world"

# ╔═╡ 42b558e5-3a94-47da-80e3-f8fa9a0f5ae4
3*"Hello"

# ╔═╡ 60ae193a-79bf-41ac-b360-fc2e36a270de
md"""
### 作業
寫一個`drop`函式，包含兩個方法：
- 如果輸入是向量， 把向量的最後一個元素剔除後回傳
- 如果輸入是矩陣， 把矩陣的最後一橫列剔除後回傳
"""

# ╔═╡ c8f57255-0fca-4170-b506-622eedc1d103
md"""
## Broadcast and Dot operation
向量化運算
"""

# ╔═╡ 605ccfe0-15b2-41be-a85f-6c0885a0cca2
md"""
# 條件與迴圈
## 條件

"""

# ╔═╡ 6dedb160-9e40-40fd-ad9b-e2e7b0c23a2d
md"""
## 迴圈

"""

# ╔═╡ bb287254-e7d5-4e5d-b224-61310ffb0f5d
md"""
## 迴圈的變數作用域 (Scope of Variable)
"""

# ╔═╡ 00708bf9-dadb-4cc5-b4f1-8b7f1d1e1e0b
md"問題：要如何修正下列程式碼?"

# ╔═╡ 793e3b05-32a8-497d-aa0d-03a81b06d709
let 
	for i = 1:5
		b = i + 1
	end
	b
end

# ╔═╡ 8a951c5f-a964-4928-a1fe-f4c2baf13038
md"""
## 透過預分配(preallocate)加速
"""

# ╔═╡ 716fd2c3-7f11-4277-9278-8b363af99005
@benchmark let
	A = [1, 2, 3, 4, 5];
	answer = fill(NaN, 5); # 類似 matlab 的 nan(5,1)
	for i = 1:5
		A_i = A[i];
		answer[i] = A_i^2;
	end
	answer
end

# ╔═╡ 97c76ceb-ad8e-428e-a92b-fb9f254cd1f9
@benchmark let
	A = [1, 2, 3, 4, 5];
	answer = []; 
	for A_i in A
		answer = [answer..., A_i^2]; # 類似 matlab 的 answer = [answer, A_i^2];
	end
	answer
end

# ╔═╡ 2a30b235-57c7-4e9e-a6fa-19f139dfda58
@benchmark let
	A = [1, 2, 3, 4, 5];
	answer = []; 
	for A_i in A
		push!(answer, A_i^2)
	end
	answer
end

# ╔═╡ 1154199e-13c4-4f4a-9d87-06564d892e7f
md"""
# 常用型別
## 數值系統

## 文字


"""

# ╔═╡ 3fbff5ed-9731-437d-a773-ec2a6961bf21
md"""
# 向量與矩陣
- `range`
- `Vector{DataType}`
- `Matrix{DataType}`
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.2.2"
LaTeXStrings = "~1.3.0"
PlutoUI = "~0.7.24"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "940001114a0147b6e4d10624276d56d531dd9b49"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.2"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "6c9fa3e4880242c666dafa4901a34d8e1cd1b243"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.24"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═7b6611e9-e9fe-425b-ba66-1454218bbfb4
# ╟─b51695fd-2fd1-490b-9095-c9d19878dd56
# ╠═d34e2dae-735a-4fd9-9958-af58e04c4ca9
# ╟─03f5e9bf-00e7-4a8d-bd73-d1f2316159f2
# ╟─e68b0d87-d103-4618-8fa6-ad34104cb8f8
# ╟─bd19cf50-5fd9-11ec-0bc5-95352ec3ead8
# ╠═e882362d-8db1-4570-a098-fd50f436f5c5
# ╟─0fd3158a-efc4-43c6-8061-9d925a13bd50
# ╠═6586ce82-1cae-4de5-96c7-79f769dd5429
# ╟─ebb7d6f1-af95-43e7-9581-5e6b9777fe39
# ╟─621fec83-b164-4988-9841-3f4622a6139f
# ╟─61acc7f6-1320-415a-9614-db079f35228b
# ╟─fae01d58-aabb-4822-ad2f-c308e1386969
# ╠═9291dbf9-d772-4ead-82ba-156fdecb172d
# ╟─49a02781-7b9a-4f57-b0ed-992d6d8ae2f1
# ╠═6cabd377-ad4f-4ead-b36c-36ad9a5a7b73
# ╟─d1f9dedf-aba4-48d8-935f-eda0092ea8cf
# ╠═f3697ee8-7de1-4698-804d-101e15da89fb
# ╟─80d895ca-4d8c-4ca3-8c76-02c09f6d7836
# ╠═0e835f9d-b45b-4063-add9-e853c85d45f5
# ╟─1b3462ed-fa28-48e1-a3dd-14263f399b6b
# ╠═aa730d31-0e37-4ac8-9b23-a443314af322
# ╠═00aaa76e-92e8-420a-b06f-391806339f8b
# ╟─11001bc8-865a-42e9-91b3-57a77211d108
# ╠═8d10e00d-a439-479a-8c56-d7923d2a39d5
# ╠═d45e0f9d-8fce-4f48-96c3-078d8098666e
# ╟─18da0620-5ef9-4b56-9598-345230edb1d7
# ╟─d017a18a-727f-440d-b42e-97e40e1dc6a1
# ╠═88d9f535-bf29-490a-be26-0c3bd63e7231
# ╟─2dc59144-3bae-4f9a-a3e7-cf6a82a27802
# ╠═47b9aba5-054b-46dc-bdf4-fac7c147f60b
# ╟─88910e9c-a8c3-47d6-948e-c646e72fc180
# ╟─161117db-6ccd-4056-8353-05aa64f6ce71
# ╠═5ee4dfff-ca59-43aa-96cd-2379dbff5e5f
# ╟─95611b36-5370-4b13-a1f0-4f8fdbfb0f3d
# ╠═01d91380-e44e-4d77-93bb-329ce2de20b3
# ╟─c287f471-ecea-4671-90d3-5dd6439f4846
# ╠═77b1d882-c45b-4889-8785-09d8b412b102
# ╠═42b558e5-3a94-47da-80e3-f8fa9a0f5ae4
# ╟─60ae193a-79bf-41ac-b360-fc2e36a270de
# ╠═c8f57255-0fca-4170-b506-622eedc1d103
# ╠═605ccfe0-15b2-41be-a85f-6c0885a0cca2
# ╠═6dedb160-9e40-40fd-ad9b-e2e7b0c23a2d
# ╟─bb287254-e7d5-4e5d-b224-61310ffb0f5d
# ╟─00708bf9-dadb-4cc5-b4f1-8b7f1d1e1e0b
# ╠═793e3b05-32a8-497d-aa0d-03a81b06d709
# ╟─8a951c5f-a964-4928-a1fe-f4c2baf13038
# ╠═716fd2c3-7f11-4277-9278-8b363af99005
# ╠═97c76ceb-ad8e-428e-a92b-fb9f254cd1f9
# ╠═2a30b235-57c7-4e9e-a6fa-19f139dfda58
# ╠═1154199e-13c4-4f4a-9d87-06564d892e7f
# ╠═3fbff5ed-9731-437d-a773-ec2a6961bf21
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
