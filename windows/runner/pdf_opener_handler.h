#ifndef WINDOWS_RUNNER_PDF_OPENER_HANDLER_H_
#define WINDOWS_RUNNER_PDF_OPENER_HANDLER_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <string>

class PDFOpenerHandler {
 public:
  PDFOpenerHandler() = default;
  ~PDFOpenerHandler() = default;

  // Register the app as default PDF opener
  static bool RegisterPdfOpener();

  // Register file association and context menu
  static bool RegisterFileAssociation();

  // Add to Path environment variable
  static bool AddToProgramFiles();

  // Register URL scheme for deep links (openpdf://)
  static bool RegisterUriScheme();

 private:
  // Helper function to write registry keys
  static bool WriteRegistryKey(const wchar_t* root_key,
                                const wchar_t* sub_key,
                                const wchar_t* value_name,
                                const wchar_t* value_data);

  // Helper function to read registry keys
  static std::wstring ReadRegistryKey(const wchar_t* root_key,
                                       const wchar_t* sub_key,
                                       const wchar_t* value_name);

  // Get the application executable path
  static std::wstring GetApplicationPath();
};

#endif  // WINDOWS_RUNNER_PDF_OPENER_HANDLER_H_
