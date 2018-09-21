
-------PARTICLESPAWNER_LIBRARY-------


function misc.create_particle_spawner(particlespawners_amount, player, particles_spawners_def, particlespawner_id)
    if type(particlespawners_amount) == "number" and particlespawners_amount > 0 then -- If particlespawners_amount is number and over of 0 create particles_spawner_def table and the loop is running on each particles_spawner
        math.abs(math.ceil(particlespawners_amount))
        local particles_spawner_def = {}
        
        local playermeta = player:get_meta()
        
        if misc.is_player_has_the_particlespawner(player, particlespawner_id) then
            error("Can not add particlespawner with same id!", 1)
            
            return
        else
            
            playermeta:set_string("active_particlespawners[" .. particlespawner_id.. "]", minetest.serialize({mode = "active", 
                particles_amount = particlespawners_amount, 
                particles_def = particles_spawners_def,
                particles_time = {start = 0, end_ = misc.max_table_value(particles_spawners_def[2])},
                standard_particles_list = {}}))
            
            --[[playermeta:set_string("active_particlespawners[" .. particlespawner_id.. "]".."[particlespawner_mode]", "active")
            playermeta:set_string("active_particlespawners[" .. particlespawner_id.. "][particlespawners_amount]", tostring(particlespawners_amount))
            playermeta:set_string("active_particlespawners[" .. particlespawner_id.. "][particles_spawners_def]", minetest.serialize(particles_spawners_def))
            playermeta:set_string("active_particlespawners[" .. particlespawner_id.. "][standard_particlespawners_list]", minetest.serialize({}))]]
            local max_table_index = table.maxn(particles_spawners_def)
            
        
            for table_index = 1, max_table_index do
                particles_spawner_def[table_index] = {}
            
                if table_index >=3 and table_index <= 7 then
                    particles_spawner_def[table_index][1] = {}
                    particles_spawner_def[table_index][2] = {}
                end
            end
    
            
            for particles_spawner = 1, particlespawners_amount do
                for particles_spawner_param = 1, max_table_index do
                    if particles_spawner_param >= 3 and particles_spawner_param <= 5 then
                        for min_or_max_param = 1, 2 do
                               particles_spawner_def[particles_spawner_param][min_or_max_param][particles_spawner] = {}
                            for point = 1, 3 do
                           
                                particles_spawner_def[particles_spawner_param][min_or_max_param][particles_spawner][point] = particles_spawners_def[particles_spawner_param][min_or_max_param][particles_spawner][point]
                            end
                        end
                    elseif particles_spawner_param < 3 or particles_spawner_param > 7 then
                        particles_spawner_def[particles_spawner_param][particles_spawner] = particles_spawners_def[particles_spawner_param][particles_spawner]
                    
                        if particles_spawner_param == 2 then
                            time = particles_spawner_def[particles_spawner_param][particles_spawner]
                        end
            
                    elseif particles_spawner_param == 5 or particles_spawner_param == 6 then
                        for min_or_maxparam = 1, 2 do
                            particles_spawner_def[particles_spawner_param][min_or_maxparam][particles_spawner] = particles_spawners_def[particles_spawner_param][min_or_maxparam][particles_spawner]
                        end
                    end
                end
        
                
                local meta = minetest.deserialize(playermeta:get_string("active_particlespawners["..particlespawner_id.."]"))
                
                meta.standard_particles_list.particlespawner_id = minetest.add_particlespawner({
                    amount = particles_spawner_def[1][particles_spawner],
                    time = particles_spawner_def[2][particles_spawner],
                    minpos = {x = particles_spawner_def[3][1][particles_spawner][1], y = particles_spawner_def[3][1][particles_spawner][2], z = particles_spawner_def[3][1][particles_spawner][3]},
                    maxpos = {x = particles_spawner_def[3][2][particles_spawner][1], y = particles_spawner_def[3][2][particles_spawner][2], z = particles_spawner_def[3][2][particles_spawner][3]},
                    minvel = {x = particles_spawner_def[4][1][particles_spawner][1], y = particles_spawner_def[4][1][particles_spawner][2], z = particles_spawner_def[4][1][particles_spawner][3]},
                    maxvel = {x = particles_spawner_def[4][2][particles_spawner][1], y = particles_spawner_def[4][2][particles_spawner][2], z = particles_spawner_def[4][2][particles_spawner][3]},
                    minacc = {x = particles_spawner_def[5][1][particles_spawner][1], y = particles_spawner_def[5][1][particles_spawner][2], z = particles_spawner_def[5][1][particles_spawner][3]},
                    maxacc = {x = particles_spawner_def[5][2][particles_spawner][1], y = particles_spawner_def[5][2][particles_spawner][2], z = particles_spawner_def[5][2][particles_spawner][3]},
                    minexptime = particles_spawner_def[6][1][particles_spawner],
                    maxexptime = particles_spawner_def[6][2][particles_spawner],
                    minsize = particles_spawner_def[7][1][particles_spawner],
                    maxsize = particles_spawner_def[7][2][particles_spawner],
                    collisiondetection = particles_spawner_def[8][particles_spawner],
                    vertical = particles_spawner_def[9][particles_spawner],
                    texture = particles_spawner_def[10][particles_spawner],
                    playername = particles_spawner_def[11][particles_spawner]
                })
                
                playermeta:set_string("active_particlespawners["..particlespawner_id.."]", minetest.serialize(meta))
                
            end
            
            --[[local particlespawner_def = playermeta:get_string("active_particlespawners["..particlespawner_id.."]")
            particlespawner_def.particles_time.start = 
            playermeta:set_string("active_particlespawners["..particlespawner_id.."][time]", minetest.serialize({start = 0, end_ = particles_spawners_def[2][1]}))]]
            
            minetest.register_globalstep(function (dtime)
                local particlespawner_mode = minetest.deserialize(player:get_meta():get_string("active_particlespawners["..particlespawner_id.."]")).mode
                if player:get_hp() > 0 and player:is_player_connected(player:get_player_name()) and particlespawner_mode == "active" then
                    local particlespawner_def = minetest.deserialize(playermeta:get_string("active_particlespawners["..particlespawner_id.."]"))
                    particlespawner_def.particles_time.start = particlespawner_def.particles_time.start + dtime
                    --[[for particlespawner_index, particlespawner_time in ipairs(particlespawner_def.particles_def[2]) do
                        particles_spawners_def[2][particlespawner_index] = particles_spawners_def[2][particlespawner_index] - dtime
                        playermeta:set_string("active_particlespawners["..particlespawner_id.."]", particlespawner_def)
                    end
                    playermeta:set_string("active_particlespawners["..particlespawner_id.."]", minetest.serialize(particlespawner_def))]]
                    --^^ playermeta:get_string("active_particlespawners["..particlespawner_id.."][time][start]") gets a nil value!!! 
                
                elseif player:get_hp() <= 0 then
                    misc.remove_particle_spawner(player, particlespawner_id)
                end
            end)
            minetest.after(misc.max_table_value(particles_spawners_def[2]), function (playermeta)
                misc.remove_particle_spawner(player, particlespawner_id)
            end, playermeta)
            
           
        end
    else
        return
    end
end
            

function misc.is_player_has_any_particlespawners (player)
    local current_player_particlespawners = minetest.deserialize(player:get_meta():get_string("active_particlespawners"))
    
    if table.maxn(current_player_particlespawners) ~= 0 then
        return true
        
    else
        return false
    end
end

function misc.is_player_has_the_particlespawner (player, particlespawner_id)
    local current_player_particlespawners = minetest.deserialize(player:get_meta():get_string("active_particlespawners"))
    
    local max_particlespawners_index = 0
    
    for search_particlespawner, particlespawner_table in pairs(current_player_particlespawners) do
        max_particlespawners_index = max_particlespawners_index + 1
        
        if search_particlespawner == particlespawner_id then
            return true
        
        end
        
        if max_particlespawners_index == table.maxn(current_player_particlespawners) then
            return false
        end
    end
end

function misc.stop_particle_spawner(player, particlespawner_id)
    if misc.is_player_has_the_particlespawner(player, particlespawner_id) then
        local particlespawner_def = minetest.deserialize(player:get_meta():get_string("active_particlespawners["..particlespawner_id.."]"))
        if particlespawner_def.mode == "active" then
            particlespawner_def.mode = "stopped"
            player:get_meta():set_string("active_particlespawners["..particlespawner_id.."]", minetest.serialize(particlespawner_def))
            
            misc.remove_particle_spawner(player, particlespawner_id)
        end
    else
        return
    end
end
        
function misc.remove_particle_spawner (player, particlespawner_id)
    local particlespawner_def = minetest.deserialize(player:get_meta():get_string("active_particlespawners["..particlespawner_id.."]"))
    
    if misc.is_player_has_the_particlespawner(player, particlespawner_id) then
        
        for standard_spawner_index, remove_standard_spawner in pairs(particlespawner_def.standard_particles_list) do
            minetest.delete_particlespawner(remove_standard_spawner, player)
        end
        
        player:get_meta():set_string("active_particlespawners[" .. particlespawner_id.."]", minetest.deserialize({}))
        
         
    end
end

function misc.continue_particle_spawner (player, particlespawner_id)
    if misc.is_player_has_the_particlespawner(player, particlespawner_id) then
        local particlespawner_def = minetest.deserialize(player:get_meta():get_string("active_particlespawners["..particlespawner_id.."]"))
        if particlespawner_def.mode == "stopped" then
            particlespawner_def.mode = "active"
            player:get_meta():set_string("active_particlespawners["..particlespawner_id.."]", minetest.serialize(particlespawner_def))
            
            misc.create_particle_spawner(particlespawner_def.particles_amount, player, particlespawner_def.particles_def, particlespawner_id)
            
        else
            return
        end
    else
        return
    end
end 

minetest.register_on_leaveplayer(function (player)
    local current_player_particlespawners = minetest.deserialize(player:get_meta():get_string("active_particlespawners")) -- HERE! To write correct player meta data in register_on_leaveplayer and register_on_joinplayer
    
    if misc.is_player_has_any_particlespawners(player) then
        for particlespawner_id, particlespawner_table in pairs(current_player_particlespawners) do
            if particlespawner_table.mode == "active" then
                local particlespawners_time = current_player_particlespawners.particlespawner_id.particles_time
                current_player_particlespawners.particlespawner_id.particles_time = {start = 0, end_ = particlespawners_time.end_ - particlespawners_time.start}
                local playermeta = player:get_meta()
            
                playermeta:set_string("active_particlespawners["..particlespawner_id.."]", minetest.serialize(current_player_particlespawners.particlespawner_id))
            end
        end
    else
        return
    end

end)

minetest.register_on_joinplayer(function (player)
    if minetest.deserialize(player:get_meta():get_string("active_particlespawners")) == nil then
        player:get_meta():set_string("active_particlespawners", minetest.serialize({}))
    end
    
    if misc.is_player_has_any_particlespawners(player) then
        local current_player_particlespawners = minetest.deserialize(player:get_meta():get_string("active_particlespawners"))
        
        for particlespawner_id, particlespawner_table in pairs(current_player_particlespawners) do
            if particlespawner_table.mode == "active" then
                
                misc.create_particle_spawner(current_player_particlespawners.particlespawner_id.particles_amount,
                    player,
                    current_player_particlespawners.particlespawner_id.particles_def,
                    particlespawner_id)
            end
        end
    end
end)

minetest.register_on_newplayer(function (player)
     playermeta:set_string("active_particlespawners", minetest.serialize({}))
end)
