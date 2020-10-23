#[[------------------------------------------

	-------------------------------
	gsandro's cmake script
	-------------------------------
	
	Project: Generic

---------------------------------------------]]# 

# set( CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/toolchain.cmake" )

#[[------------------------------------------------
	Project description and (meta) information SVN
----------------------------------------------------]]

set( META_PROJECT_NAME					"Template" )
set( META_PROJECT_TITLE					"Software" )
set( META_PROJECT_DESCRIPTION			"Internal Projekt" )
set( META_AUTHOR_ORGANIZATION			"SUPER SOFTWARE AG" )
set( META_AUTHOR_DOMAIN					"https://www.super.org" )


#[[------------------------------------------------
	Set Intern-Version here
----------------------------------------------------]]
set( META_DEVICE_NAME					"SUP4-A01" )
set( IDENT_SW_VER_HI 					1 ) # Hardware Version
set( IDENT_SW_VER_MID					0 ) # Function Version
set( IDENT_SW_VER_LOW					0 ) # Correction Version
set( IDENT_SW_VER_TEST					1 ) # Test Version (0 for release or release-candidate)

#[[------------------------------------------------
	set Oem-version here
----------------------------------------------------]]

set( META_OEMVER_SW_SUPPLIER					0x00 ) 																			# Software Supplier Identification

#[[------------------------------------------------
	add 0 to versions < 10
----------------------------------------------------]]

if( ${IDENT_SW_VER_HI} LESS 10 )
	string(REPLACE "${IDENT_SW_VER_HI}" "0${IDENT_SW_VER_HI}" META_IDENT_SW_VER_HI  ${IDENT_SW_VER_HI})
else()
	SET( META_IDENT_SW_VER_HI ${IDENT_SW_VER_HI} )
endif()

if( ${IDENT_SW_VER_MID} LESS 10 )
	string(REPLACE "${IDENT_SW_VER_MID}" "0${IDENT_SW_VER_MID}" META_IDENT_SW_VER_MID  ${IDENT_SW_VER_MID})
else()
	SET( META_IDENT_SW_VER_MID ${IDENT_SW_VER_MID} )
endif()

if( ${IDENT_SW_VER_LOW} LESS 10 )
	string(REPLACE "${IDENT_SW_VER_LOW}" "0${IDENT_SW_VER_LOW}" META_IDENT_SW_VER_LOW  ${IDENT_SW_VER_LOW})
else()
	SET( META_IDENT_SW_VER_LOW ${IDENT_SW_VER_LOW} )
endif()

if( ${IDENT_SW_VER_TEST} LESS 10 )
	string(REPLACE "${IDENT_SW_VER_TEST}" "0${IDENT_SW_VER_TEST}" META_IDENT_SW_VER_TEST  ${IDENT_SW_VER_TEST})
else()
	SET( META_IDENT_SW_VER_TEST ${IDENT_SW_VER_TEST} )
endif()

#[[------------------------------------------------
	version-control infos
----------------------------------------------------]]
include(FindSubversion)
find_package( Subversion )
if( SUBVERSION_FOUND )
	Subversion_WC_INFO( ${CMAKE_SOURCE_DIR} PROJECT )
	Subversion_WC_LOG( ${CMAKE_SOURCE_DIR} PROJECT )
	set(SVN_REV ${PROJECT_WC_REVISION} )
	set(SVN_CHANGE_LOG ${PROJECT_LAST_CHANGED_LOG} )
	set(SVN_AUTHOR ${PROJECT_WC_LAST_CHANGED_AUTHOR} )
	set(SVN_URL ${PROJECT_WC_URL} )
else()
	set( SVN_REV 001 )
	set( SVN_CHANGE_LOG " " )
endif()

if( SVN_AUTHOR )
	set( META_AUTHOR_MAINTAINER		"${SVN_AUTHOR}@super.org" )
else()
	set( META_AUTHOR_MAINTAINER		"gsandro" )
endif()

#[[------------------------------------------------
	set version infos
----------------------------------------------------]]

set( META_SW_VERSION_REVISION			${SVN_REV} )

set( META_SW_VERSION						"${META_IDENT_SW_VER_HI}-${META_IDENT_SW_VER_MID}-${META_IDENT_SW_VER_LOW}" )
if( ${IDENT_SW_VER_TEST} GREATER 0 )
	set( META_SW_VERSION						"${META_SW_VERSION}-T${META_IDENT_SW_VER_TEST}" )
elseif( ${SW_RELEASE_CANDIDATE} )
	set( META_SW_VERSION						"${META_SW_VERSION}-C" )
endif()
set( META_SW_NAME_VERSION				"SW-${META_PROJECT_NAME}-${META_SW_VERSION}" )
# with SVN: set( META_SW_NAME_VERSION				"SW-${META_PROJECT_NAME}-${META_SW_VERSION} (${META_SW_VERSION_REVISION})" )

string(TIMESTAMP META_SW_COMPILATION_DATE	"%d.%m.%Y %H:%M")
string(TIMESTAMP META_SW_COMPILATION_YEAR	"%Yu")
string(TIMESTAMP META_SW_COMPILATION_WEEK	"%Uu")

set( META_HW_VERSION_REVISION			${SVN_REV} )
set( META_HW_NAME_VERSION				"${META_PROJECT_NAME} v${META_HW_VERSION_MAJOR}-${META_HW_VERSION_MINOR}-${META_HW_VERSION_PATCH} (${META_HW_VERSION_REVISION})" )

set( META_IDENTIFICATION_STRING
	"Project_SW_Info: ${META_SW_NAME_VERSION}\ "
	"Project_HW_Info: ${META_PROJECT_NAME}\ "
	"Author_Organization: ${META_AUTHOR_ORGANIZATION}\ "
	"Build_Type: ${CMAKE_BUILD_TYPE}\ "
)

set( INSTALL_SUFFIX						"${CMAKE_PROJECT_NAME}" )
set( INCLUDE_INSTALL_PATH				"${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_SUFFIX}" )

#[[------------------------------------------------
	set compatibility with IDE's
----------------------------------------------------]]

set_property( GLOBAL PROPERTY USE_FOLDERS ON )
set( IDE_FOLDER "" )

#[[------------------------------------------------
	set version-control status
----------------------------------------------------]]

# execute_process( 
# 	COMMAND "SubWCRev.exe" ${CMAKE_SOURCE_DIR} -nm
# 	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
# 	RESULT_VARIABLE SVN_MODMIX_RESULT
# )

# set( SVN_OK  FALSE )
# set( SVN_MOD FALSE )
# set( SVN_MIX FALSE )
# set( SVN_UNV FALSE )
# set( SVN_STRING "" )

# if(NOT "${SVN_MODMIX_RESULT}" STREQUAL "0")
# 	set( SVN_STRING "--ERR" )
# 	if("${SVN_MODMIX_RESULT}" STREQUAL "7")
# 		set( SVN_MOD TRUE )
# 		set( SVN_STRING "--MOD" )
# 	elseif("${SVN_MODMIX_RESULT}" STREQUAL "8")
# 		set( SVN_MIX TRUE )
# 		set( SVN_STRING "--MIX" )
# 	elseif("${SVN_MODMIX_RESULT}" STREQUAL "11")
# 		set( SVN_UNV TRUE )
# 		set( SVN_STRING "--UNVERSIONED" )
# 	endif()
# else(
# 	set( SVN_OK TRUE )
# )
# endif()

#[[------------------------------------------------
	Print Messages
----------------------------------------------------]]
set( META_SW_NAME_FINAL ${META_SW_NAME_VERSION}_v${SVN_REV}${SVN_STRING} )
set( USER $ENV{USERNAME} )
message( "--------------------------------------------------------------------" )
message( "	Hi ${USER} you are building" )
message( "	${META_SW_NAME_FINAL}" )
if ( NOT CMAKE_BUILD_TYPE )
	message( FATAL_ERROR "Choose the type of build : None Debug Release." )
else()
	message( "	Current build type is : ${CMAKE_BUILD_TYPE}" )
endif()
message( "	URL: ${SVN_URL}" )
message( "--------------------------------------------------------------------" )
