%Monopoly Monte Carlo simulation
function winner = project_1_monte_carlo(p1, p2)
%players cash

p_cash = [p1, p2]; %[p1_cash; p2_cash]
size = 40;
%housing level


%owned spots
owned_spots = -ones(1, size);
houses_per_spot = zeros(1, size);

%Initially start at GO
pos = [1, 1];
turn = 1;
while true
    %see who's turn it is
    player = mod(turn-1, 2) + 1;

    %odd number player 1, even number -> player 2
    dice_roll = randi(6);

    %move player
    current_Pos = pos(player);
    pos(player) = mod(pos(player) - 1 + dice_roll, size) + 1;

    if pos(player) < current_Pos %Passed go

        %Collect 200 dollars
        p_cash(player) = p_cash(player) + 200;
        
    end

    spot = pos(player);

    if spot ~= 1

        if owned_spots(spot) == -1 && p_cash(player) >= 200

        %buy the land
        owned_spots(spot) = player;
        p_cash(player) = p_cash(player) - 200;

       

    

        elseif owned_spots(spot) == player  %add a house
            %calculate payment
            M = houses_per_spot(spot) + 1;
            payment = M * 100;
            %check if player has enough money;
            if p_cash(player) >= payment

            p_cash(player) = p_cash(player) - payment;
            houses_per_spot(spot) = M;
            end
     

    
              

        %see if other player owns the spot
    elseif owned_spots(spot) == 3 - player

            %pay the other player based on number of houses
            rent = 50 * 4^houses_per_spot(spot);

            p_cash(player) = p_cash(player) - rent;
            p_cash(3 - player) = p_cash(3 - player) + rent;
        end
        
     end

     %see if cash is negative
     if p_cash(player) <= 0
         winner = 3 - player;
         return
     end
     turn = turn + 1;

end
