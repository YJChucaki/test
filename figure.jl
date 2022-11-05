
using YAML,ApproxOperator,CairoMakie

ndiv = 10
config = YAML.load_file("./yml/bar_z.yml")
path = "./msh/bar_10.msh"
elements, nodes = importmsh(path,config)

nₚ = length(nodes)
nₑ = length(elements["Ω"])

s = 2.5/ndiv*ones(nₚ)


push!(nodes,:s₁=>s,:s₂=>s,:s₃=>s)
set𝝭!(elements["Ω"])

f = Figure()
Axis(f[1, 1])

n = length(elements["Ω"][1].𝓖)
x = zeros(n*nₑ)
𝝭 = zeros(n*nₑ,nₚ)
for (e,element) in enumerate(elements["Ω"])
    𝓒 = element.𝓒
    𝓖 = element.𝓖
    for (i,ξ) in enumerate(𝓖)
        x[(e-1)*n+i] = ξ.x
        N = ξ[:𝝭]
        for (j,xᵢ) in enumerate(𝓒)
            I = xᵢ.𝐼
            𝝭[(e-1)*n+i,I] = N[j]
        end
    end
end
for i in 1:nₚ
    lines!(x,𝝭[:,i])
end

display(f)