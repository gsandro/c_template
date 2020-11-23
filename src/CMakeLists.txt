#[[------------------------------------------

	-------------------------------
	gsandro's cmake script
	-------------------------------
	
	Project: Generic

---------------------------------------------]]# 

add_executable(	${META_PROJECT_NAME}
	main.c
	CentrifugeTest.c
	Fault.cpp
	fb_allocator.c
	LockGuard.cpp
	Motor.c
	sm_allocator.c
	StateMachine.c
	x_allocator.c
)

target_include_directories( ${META_PROJECT_NAME} PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)
