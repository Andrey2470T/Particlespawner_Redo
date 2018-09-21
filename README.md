# Particlespawner_Redo
This is a library that modifies standard minetest particlespawner API (WIP very)

It adds few new features as:
1. Enabled to call immediately FEW particlespawners in different places by one function.
2. Particlespawners will stay after restarting of the game if it has not been expired.
3. More functions that implementing removal, stopping, continuing, checking_for_id and etc.

### Documentation ###

# misc.create_particle_spawner(particlespawner_amount, player, particles_spawners_def, particlespawner_id)
  --Adds particlespawner.
  
  # Arguments:
  particlespawner_amount -- amount of particlespawners that may be spawned in different places 
  player -- PlayerRef
  particles_spawners_def -- table with tables of each particlespawners:
      {amount_params = {n-amount}, -- amount of particlespawners (number literal)
       time_params = {n-time}, -- time of each particlespawners (number literal)
       pos_params = { -- position of each particlespawner where it will be spawned (minimal and maximal ones for each one)
        min = {n-particlespawners_tables}, -- minimal position, for each particlespawner this table must be {x, y, z} (without varyables)
        max = {n-particlespawners_tables}, --maximal position, same as above
       },
       vel_params = { -- velocity (min, max) of each particlespawner, tables below must be same as above
        min = {n-particlespawners_tables},
        max = {n-particlespawner_tables},
       },
       acc_params = { -- acceleration (min, max) of each particlespawner, tables must be same as above
        min = {n-particlespawners_tables},
        max = {n-particlespawner_tables},
       },
       exptime_params = { -- expiration time (min, max) of each particlespawner, tables must be same as above
        min = {n-particlespawners_tables},
        max = {n-particlespawner_tables},
       },
       size_params = { -- size (min, max) of each particlespawner, tables must be same as above
        min = {n-particlespawners_tables},
        max = {n-particlespawner_tables},
       },
       collisiondetect_param = {n-collision_detections}, -- collision with nodes/objects for each particlespawner (boolean)
       vertical_param = {n-verticals}, -- vertical parameter, defines whether the particlespawner will be going to Y axis (boolean)
       texture_param = {n-textures_names}, -- textures for each particlespawner (string literal)
       playername_param = {n-playernames} -- table with player names that defines who the current particlespawner will be applied to.
   
   particlespawner_id -- name of particlespawner (string literal)
   # Note:  name parameters as time_params, vel_params, exptime_params must NOT be, just tables with values!
 
 
 # misc.is_player_has_any_particlespawners(player)
   --Defines whether a player has any particlespawners (returns boolean)
   
 # misc.is_player_has_the_particlespawner(player, particlespawner_id)
   --Defines whether a player has certain particlespawner (returns boolean)
   
 # misc.stop_particle_spawner(player, particlespawner_id)
   --Stops a particlespawner (makes it from active_mode to stop_mode) 
   # Note:  it will NOT remove actual player_meta_data, just change a mode
 
 # misc.continue_particle_spawner(player, particlespawner_id)
   --Continues a particlespawner (makes it from stop_mode to active_mode)
   
 # misc.remove_particle_spawner(player, particlespawner_id)
   --Removes a particlespawner (with player_meta_data)
   
        
       
