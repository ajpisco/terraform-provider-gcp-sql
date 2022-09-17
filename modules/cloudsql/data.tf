data "google_project" "current_project" {
}

data "google_compute_network" "network" {
  name = "${data.google_project.current_project.project_id}-network"
}