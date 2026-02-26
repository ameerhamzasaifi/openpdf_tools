#include "pdf_opener_handler.h"
#include <windows.h>
#include <shellapi.h>
#include <shlobj.h>
#include <iostream>

bool PDFOpenerHandler::RegisterPdfOpener() {
  // Register file association
  if (!RegisterFileAssociation()) {
    return false;
  }

  // Register URI scheme
  if (!RegisterUriScheme()) {
    return false;
  }

  return true;
}

bool PDFOpenerHandler::RegisterFileAssociation() {
  std::wstring app_path = GetApplicationPath();
  if (app_path.empty()) {
    return false;
  }

  // Register .pdf file extension
  // HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice
  // This associates with the application
  
  // Registry path for file association
  const wchar_t* file_ext_key = L"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\FileExts\\.pdf\\UserChoice";
  
  // For modern Windows, we use progid instead
  // Register ProgID
  if (!WriteRegistryKey(L"HKCU", 
                         L"Software\\Classes\\.pdf",
                         L"",
                         L"OpenPDFDocument")) {
    return false;
  }

  // Create the OpenPDFDocument ProgID
  std::wstring progid_path = L"Software\\Classes\\OpenPDFDocument";
  if (!WriteRegistryKey(L"HKCU", progid_path, L"", L"PDF Document - OpenPDF Tools")) {
    return false;
  }

  // Set the icon
  std::wstring icon_path = app_path + L",0";
  if (!WriteRegistryKey(L"HKCU", progid_path + L"\\DefaultIcon", L"", icon_path.c_str())) {
    return false;
  }

  // Set the open command
  std::wstring open_command = L"\"" + app_path + L"\" \"%1\"";
  if (!WriteRegistryKey(L"HKCU", 
                         progid_path + L"\\shell\\open\\command",
                         L"",
                         open_command.c_str())) {
    return false;
  }

  // Add to "Open with" programs
  std::wstring open_with_path = L"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\FileExts\\.pdf\\UserChoice";
  
  return true;
}

bool PDFOpenerHandler::RegisterUriScheme() {
  std::wstring app_path = GetApplicationPath();
  if (app_path.empty()) {
    return false;
  }

  // Register openpdf:// URL scheme
  const wchar_t* url_scheme_key = L"Software\\Classes\\openpdf";
  
  if (!WriteRegistryKey(L"HKCU", url_scheme_key, L"", L"OpenPDF Handler")) {
    return false;
  }

  if (!WriteRegistryKey(L"HKCU", url_scheme_key, L"URL Protocol", L"")) {
    return false;
  }

  // Set icon
  std::wstring icon_path = app_path + L",0";
  if (!WriteRegistryKey(L"HKCU", 
                         url_scheme_key + L"\\DefaultIcon",
                         L"",
                         icon_path.c_str())) {
    return false;
  }

  // Set open command
  std::wstring open_command = L"\"" + app_path + L"\" \"%1\"";
  if (!WriteRegistryKey(L"HKCU",
                         url_scheme_key + L"\\shell\\open\\command",
                         L"",
                         open_command.c_str())) {
    return false;
  }

  return true;
}

bool PDFOpenerHandler::WriteRegistryKey(const wchar_t* root_key_name,
                                         const wchar_t* sub_key,
                                         const wchar_t* value_name,
                                         const wchar_t* value_data) {
  HKEY root_key = HKEY_CURRENT_USER;
  if (wcscmp(root_key_name, L"HKCU") != 0) {
    root_key = HKEY_CURRENT_USER;  // Default to HKCU
  }

  HKEY hkey;
  LONG result = RegCreateKeyExW(root_key, sub_key, 0, NULL, 
                                 REG_OPTION_NON_VOLATILE, KEY_WRITE, NULL, 
                                 &hkey, NULL);
  
  if (result != ERROR_SUCCESS) {
    return false;
  }

  result = RegSetValueExW(hkey, value_name, 0, REG_SZ,
                          (const BYTE*)value_data,
                          (wcslen(value_data) + 1) * sizeof(wchar_t));

  RegCloseKey(hkey);
  return result == ERROR_SUCCESS;
}

std::wstring PDFOpenerHandler::ReadRegistryKey(const wchar_t* root_key_name,
                                                const wchar_t* sub_key,
                                                const wchar_t* value_name) {
  HKEY root_key = HKEY_CURRENT_USER;
  if (wcscmp(root_key_name, L"HKCU") != 0) {
    root_key = HKEY_CURRENT_USER;
  }

  HKEY hkey;
  LONG result = RegOpenKeyExW(root_key, sub_key, 0, KEY_READ, &hkey);
  
  if (result != ERROR_SUCCESS) {
    return L"";
  }

  wchar_t value_data[MAX_PATH] = {0};
  DWORD value_size = sizeof(value_data);
  
  result = RegQueryValueExW(hkey, value_name, NULL, NULL,
                           (LPBYTE)value_data, &value_size);

  RegCloseKey(hkey);
  
  if (result == ERROR_SUCCESS) {
    return std::wstring(value_data);
  }
  
  return L"";
}

std::wstring PDFOpenerHandler::GetApplicationPath() {
  wchar_t module_path[MAX_PATH] = {0};
  
  if (GetModuleFileNameW(NULL, module_path, MAX_PATH) == 0) {
    return L"";
  }

  return std::wstring(module_path);
}
