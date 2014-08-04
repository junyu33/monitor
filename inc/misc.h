#ifndef MONITOR_MISC_H
#define MONITOR_MISC_H

#include <windows.h>
#include "ntapi.h"

void misc_init();

uint32_t pid_from_process_handle(HANDLE process_handle);
uint32_t pid_from_thread_handle(HANDLE thread_handle);
uint32_t parent_process_id();

BOOL is_directory_objattr(const OBJECT_ATTRIBUTES *obj);
uint32_t path_from_handle(HANDLE handle,
    wchar_t *path, uint32_t path_buffer_len);
uint32_t path_from_object_attributes(const OBJECT_ATTRIBUTES *obj,
    wchar_t *path, uint32_t buffer_length);
int ensure_absolute_path(wchar_t *out, const wchar_t *in, int length);

void hide_module_from_peb(HMODULE module_handle);

void get_ip_port(const struct sockaddr *addr, const char **ip, int *port);

int is_shutting_down();

#define COPY_UNICODE_STRING(local_name, param_name) \
    UNICODE_STRING local_name; wchar_t local_name##_buf[MAX_PATH+128]; \
    local_name.Length = local_name.MaximumLength = 0; \
    local_name.Buffer = local_name##_buf; \
    memset(local_name##_buf, 0, sizeof(local_name##_buf)); \
    if(param_name != NULL && \
            param_name->MaximumLength < sizeof(local_name##_buf)) { \
        local_name.Length = param_name->Length; \
        local_name.MaximumLength = param_name->MaximumLength; \
        memcpy(local_name.Buffer, param_name->Buffer, \
            local_name.MaximumLength); \
    }

#define COPY_OBJECT_ATTRIBUTES(local_name, param_name) \
    OBJECT_ATTRIBUTES local_name; \
    memset(&local_name, 0, sizeof(local_name)); \
    COPY_UNICODE_STRING(local_name##_str, unistr_from_objattr(param_name)); \
    if(param_name != NULL) { \
        memcpy(&local_name, param_name, sizeof(local_name)); \
        local_name.ObjectName = &local_name##_str; \
    }

#define FILE_NAME_INFORMATION_REQUIRED_SIZE \
    sizeof(FILE_NAME_INFORMATION) + sizeof(wchar_t) * MAX_PATH

#endif