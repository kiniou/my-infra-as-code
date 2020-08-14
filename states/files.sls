{% for file, file_config in pillar.get('files', {}).items() %}
{{file}}:
  file.managed:
    - makedirs: true
    - contents_pillar: files:{{file}}:contents
{% endfor %}
