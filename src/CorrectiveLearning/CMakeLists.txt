# This project is designed to be built outside the Insight source tree.
PROJECT(segAdapter)

# Find ITK.
FIND_PACKAGE(ITK)
IF(ITK_FOUND)
  INCLUDE(${ITK_USE_FILE})
ELSE(ITK_FOUND)
  MESSAGE(FATAL_ERROR
          "Cannot build without ITK.  Please set ITK_DIR.")
ENDIF(ITK_FOUND)

ADD_EXECUTABLE(sa segAdapter.cxx)
ADD_EXECUTABLE(bl BiasLearn.cxx)

TARGET_LINK_LIBRARIES(sa ${ITK_LIBRARIES})
TARGET_LINK_LIBRARIES(bl ${ITK_LIBRARIES})

