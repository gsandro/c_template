#[[------------------------------------------

	-------------------------------
	gsandro's cmake script
	-------------------------------
	
	Project: Generic

---------------------------------------------]]# 


if(NOT OPTION_BUILD_TEST)
    return()
endif()

add_custom_target(src)

# add_subdirectory(bla)