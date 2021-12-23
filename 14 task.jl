#идём по 4 сторонам, расставляем маркеры, избегая перегородки (обходя их)
#возвращаемся в начальную позицию и ставим маркер
function krest!(r)
    mas=[]
    for side in [Nord,West,Sud,Ost]
        while true
            if isborder(r,side)==false
                move!(r,side)
                putmarker!(r)
                push!(mas,inverse(side))
            else
                f=detour(r,side,mas)
                if f==false
                    break
                end
                putmarker!(r)
            end
        end
        way_back(r,mas)
        mas=[]
    end
    putmarker!(r)
end

#заменяет направление на 90 градусов
function inverse90(side)
    HorizonSide(mod(Int(side)+1, 4))
end

#заменям направление на 180 градусов
function inverse(side::HorizonSide) 
    side=HorizonSide(mod(Int(side)+2,4)) 
end

#обходим перегородку
function detour(r,side,mas)
    count=0
    f=true
    while isborder(r,side)==true
        if isborder(r,inverse90(side))==true
            f=false
            break
        end
        move!(r,inverse90(side))
        push!(mas,inverse(inverse90(side)))
        count+=1
    end
    if f==true
        move!(r,side)
        push!(mas,inverse(side))
        while isborder(r,inverse(inverse90(side)))
            move!(r,side)
            push!(mas,inverse(side))
        end
        for _ in 1:count
            move!(r,inverse(inverse90(side)))
            push!(mas,inverse90(side))
        end
    end
    return f
end

#возвращаемся назад
function way_back(r,mas)
    for i in 0:(length(mas)-1)
        move!(r,mas[length(mas)-i])
    end
end