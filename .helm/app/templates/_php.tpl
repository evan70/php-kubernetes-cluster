{{- define ".helm.php" }}
image: php-kubernetes-cluster/php:latest
imagePullPolicy: Never
securityContext:
  runAsUser: 1000
  runAsGroup: 1000
volumeMounts:
  - name: source-code
    mountPath: /var/www/html
  - name: sqlite-data
    mountPath: /var/www/html/database # Môžete prispôsobiť, kde chcete uložiť súbor databázy
env:
  - name: DB_CONNECTION
    value: 'sqlite'
  - name: DB_DATABASE
    value: '/var/www/html/database/database.sqlite' # Cesta k súboru SQLite
{{- end }}

{{- define ".helm.php_mounts" }}
- name: source-code
  persistentVolumeClaim:
    claimName: source-code-pvc
- name: sqlite-data
  persistentVolumeClaim:
    claimName: sqlite-data-pvc # Toto je voliteľné, ak chcete uložiť súbor SQLite na persistovaný objem
{{- end }}
