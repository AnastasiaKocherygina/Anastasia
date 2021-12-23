#из исходной позиции идём в левый нижний угол
#ходим снизу вверх и проставляем маркеры, избегая перегородок
#возвращаемся вниз, делаем шаг вправо и проделываем тоже самое до конца поля
#возвращаемся в левый нижний угол и оттуда в исходную позицию
function main(r)
    mas_glob=[]
    mas=[]
    move_to_wall(r,Sud,mas_glob)
    wall(r,West,mas_glob)
    while true
        putmarker!(r)
        while true
            if isborder(r,Nord)==false
                move!(r,Nord)
                putmarker!(r)
                push!(mas,inverse(Nord))
            else
                f=detour(r,Nord,mas)
                if f==false
                    break
                end
                putmarker!(r)
            end
        end
        way_back(r,mas)
        mas=[]
        if isborder(r,Ost)==true
            break
        else
            move!(r,Ost)
        end
    end
    wall(r,West,mas)
    way_back(r,mas_glob)
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

#если нет стенки, идём, а иначе обходим стенку и возвращаемся на определённое кол-во шагов
function move_to_wall(r,side,mas_glob)
    while true
        if isborder(r,side)==false
            move!(r,side)
            push!(mas_glob,inverse(side))
        else
            mas=[]
            f=detour(r,side,mas)
            if f==false
                way_back(r,mas)
                break
            else
                for i in mas
                    push!(mas_glob,i)
                end
            end
        end
    end
end

#идём, пока нет стенки
function wall(r,side,mas)
    while isborder(r,side)==false
        move!(r,side)
        push!(mas,inverse(side))
    end
end