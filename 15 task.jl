#идём в левый нижний угол, обходя все "препятствия"
#идём по 4 сторонам и проставляем маркеры по периметру
#возвращаемся в исходное положение по насчитанным ранее шагам (вправо без ограничений, а вверх избегая перегородки)
function perimetr!(r::Robot)
    vertically,horizontal=angle(r)
    for side in (Nord,Ost,Sud,West)
        while isborder(r,side)==false
            putmarkers!(r,side)
        end
    end
    moves!(r,Ost,horizontal)
    moves1!(r,Nord,vertically)
end

#насчитываем кол-во шагов в определённую сторону (пока нет стенки)
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

#идём определённое кол-во шагов в определённую сторону
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

#идём определённое кол-во шагов в сторону, но избегаем стенки (обходим их справа)
function moves1!(r::Robot,side::HorizonSide,num_steps::Int)
    q=0
    while q<num_steps 
        if isborder(r,Nord)==true
            while isborder(r,side)==true
                move!(r,Ost)
            end
            move!(r,Nord)
            q+=1
            if isborder(r,West)==true
                while isborder(r,West)==true
                    move!(r,Nord)
                    q+=1
                end
            end
            move!(r,West)
        end
        if q<num_steps
        move!(r,side)
        q+=1
        end
    end
end

#идём в сторону и проставялем маркеры на всём пути
function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
    if isborder(r,side)==true
        putmarker!(r)
    end
end

#идём в левый нижний угол, обходя стенки
function angle(r::Robot)
    vertically=0
    horizontal=0
    while (isborder(r,Sud)==false || isborder(r,West)==false)
        vertically+=moves!(r,Sud)
        horizontal+=moves!(r,West)
        repeat
    end
    return vertically,horizontal
end