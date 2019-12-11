module "kubernetes-engine_beta-private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "6.1.1"

  ip_range_pods     = "${var.project_id}-pods-secondary-ip-range"
  ip_range_services = "${var.project_id}-services-secondary-ip-range"
  name              = "${var.project_id}-cluster"
  project_id        = var.project_id
  network           = google_compute_network.network.name
  subnetwork        = google_compute_subnetwork.subnetwork.name
  regional          = var.regional
  region            = var.region
  zones             = slice(var.zones, 0, 1)
  node_pools = [
    {
      name        = "default-node-pool",
      min_count   = 1,
      max_count   = 3,
      preemptible = true
    },
  ]
}