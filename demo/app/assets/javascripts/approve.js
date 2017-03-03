changeColor('vertical_nav_approve')

@approve_request=() ->
  result = raise_confirm('Do you want to approve this?')
  if !result
    event.preventDefault()

@deny_request=() ->
  result = raise_confirm('Do you want to deny this?')
  if !result
    event.preventDefault()
