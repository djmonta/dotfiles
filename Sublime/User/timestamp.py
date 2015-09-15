import sublime, sublime_plugin
from datetime import datetime

TIMESTAMP_PATTERN = 'Last\sModified:\s+20[0-9][0-9]-\d+-\d+\s+\d+:\d+:\d+(\.\d+)?'

class InsertTimestampCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    timestamp = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
    replacement = 'Last Modified: %s' % timestamp
    for r in self.view.sel():
      if r.empty():
        self.view.insert (edit, r.a, replacement)
      else:
        self.view.replace (edit, r, replacement)

class UpdateTimestampListener(sublime_plugin.EventListener):
    def on_pre_save(self, view):
      if view.settings().get("insert_timestamp_on_save") == True:
        region = view.find(TIMESTAMP_PATTERN, 0)
        if region:
          view.sel().clear()
          view.sel().add(region)
          view.run_command("insert_timestamp")
