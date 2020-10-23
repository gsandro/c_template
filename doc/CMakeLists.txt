#[[------------------------------------------

	-------------------------------
	gsandro's cmake script
	-------------------------------
	
	Project: Generic

---------------------------------------------]]# 

if(OPTION_BUILD_DOC)
  add_subdirectory(sw)
endif()

if(OPTION_BUILD_NOTE)
  add_subdirectory(release)
endif()
