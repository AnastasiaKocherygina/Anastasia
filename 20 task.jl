#ходим "змейкой" в поисках горизонтальных перегородок
#если находим горизонтальную перегородку над собой, то насчитываем её (но не каждую клеточку, а цельную перегородку)
function num_horizont(r::Robot)
    side=Ost
    num=0
    while isborder(r,Nord)==false
        while isborder(r,side)==false
            if borders(r,side)==true
                num+=1
                walk_by(r,side)
            end
        end
        move!(r,Nord)
        side=inverse(side)
    end
    return num
end

#идём до конца
function borders(r::Robot,side::HorizonSide) 
    while isborder(r,Nord)==false 
        if isborder(r,side)==true
            return false
        end
        move!(r,side) 
    end
    return true
end

#"гуляем" под стенкой
function walk_by(r::Robot,side::HorizonSide)
    while isborder(r,Nord)==true 
        move!(r,side) 
    end
end

#меняем направление на 180 градусов
function inverse(side) 
    side=HorizonSide(mod(Int(side)+2,4)) 
end