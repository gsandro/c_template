#[[------------------------------------------

	-------------------------------
	gsandro's cmake script
	-------------------------------
	
	Project: Generic

---------------------------------------------]]# 

cmake_minimum_required( VERSION 3.10 FATAL_ERROR )

set(CMAKE_BUILD_TYPE DEBUG)

include(project/project.cmake)
include(project/UseLATEX.cmake)

message( "project name is ${META_PROJECT_NAME}")
project( ${META_PROJECT_NAME} C CXX )

option( OPTION_BUILD_SRC        "Build source files."                                    OFF   )
option( OPTION_BUILD_DOC        "Build documentation."                                   ON    )
option( OPTION_BUILD_NOTE       "Build release notes."                                   ON    )
option( OPTION_BUILD_TEST       "Build tests."                                           OFF   )

if(OPTION_BUILD_TEST)
	include( CTest )
endif()

#[[------------------------------------------------
	add Project Modules (Software and Dokumentation)
----------------------------------------------------]]

add_subdirectory( src ) # source files
add_subdirectory( doc ) # documentation
add_subdirectory( tests ) # test files

