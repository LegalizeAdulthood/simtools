function(target_install name)
    install(TARGETS ${name}
        RUNTIME_DEPENDENCY_SET ${name}_deps
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
    install(RUNTIME_DEPENDENCY_SET ${name}_deps
        PRE_EXCLUDE_REGEXES [[api-ms-]] [[ext-ms-]]
        POST_EXCLUDE_REGEXES [[.*[/\\]system32[/\\].*\.dll$]]
        DESTINATION ${CMAKE_INSTALL_BINDIR})
endfunction()
