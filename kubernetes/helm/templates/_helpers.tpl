{{/* vim: set filetype=mustache: */}}

{{- define "bp.name" -}}
{{- .Values.app.name | default .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bp.containerImage" -}}
{{ $tag := default .Values.app.version .Values.containerTemplate.imageTag }}
{{- printf "%s:%s" .Values.containerTemplate.image $tag | quote -}}
{{- end -}}

{{- define "bp.serviceName" -}}
{{- .Values.service.name | default .Values.app.name | default .Release.Name | trunc 63 }}
{{- end -}}

{{- define "bp.ingressName" -}}
{{- .Values.ingress.name | default .Values.app.name | default .Release.Name | trunc 63 }}
{{- end -}}

{{- define "bp.fullName" -}}
{{- $name := default .Release.Name .Values.app.name -}}
{{- printf "%s-%s" $name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bp.version" -}}
{{- .Values.app.version | default .Values.containerTemplate.imageTag | default .Chart.AppVersion -}}
{{- end -}}

{{- define "bp.selectorLabels" -}}
app: {{ include "bp.name" . }}
{{- end -}}

{{- define "bp.labels" -}}
helm.sh/chart: {{ include "bp.chart" . }}
app.kubernetes.io/version: {{ include "bp.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "bp.fullName" . }}
{{ include "bp.selectorLabels" . }}
{{- end -}}
