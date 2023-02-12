# Xcode File Generator

Used to automate the creation of the files.

### MVVM Files

The template `MVVMTemplate` contains the template to create the following files:
- `__TEMPLATE__Configurator.swift`
- `__TEMPLATE__Router.swift`
- `__TEMPLATE__ViewModel.swift`
- `__TEMPLATE__ViewController.swift`
- `__TEMPLATE__View.swift`
- `__TEMPLATE__Data.swift`

### UI Component Files

The template `UIComponentTemplate` contains the template to create the following files:
- `__TEMPLATE__.swift`
- `__TEMPLATE__Content.swift`
- `__TEMPLATE__Style.swift`

## Extensibility

The project is created so it's very easy to create new file templates, the new templates just need to conform to `FileTemplate`.
