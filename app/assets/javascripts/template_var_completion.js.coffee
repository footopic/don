$ ->
  vars = [
    ['year',  '年(2桁) 00-99'],
    ['Year',  '年 2000-9999'],
    ['month', '月 01-12'],
    ['day',   '日 01-31'],
    ['week',  '曜日 Mon-Sun'],
    ['cDay',  '歴日 1-365'],
    ['cWeek', '暦週 1-52'],
    ['me',    'id toshino'],
    ['name',  '名前 歳納京子']
  ]

  template_var = [{
    match: /%\{([\-+\w]*)$/
    search: (term, callback) ->
      callback $.map(vars, (tvar) ->
        if tvar[0].indexOf(term) == 0 then tvar.join(':') else null
      )
    replace: (value) ->
      "%{" + value.split(':')[0] + "}"
    template: (value) ->
      value
    index: 1
    maxCount: 8
  }]
  $('#template_text').textcomplete template_var
