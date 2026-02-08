class UserRepoModel {
  int? id;
  String? nodeId;
  String? name;
  String? fullName;
  bool? private;
  String? htmlUrl;
  String? description;
  bool? fork;
  String? releasesUrl;
  String? deploymentsUrl;
  String? createdAt;
  String? updatedAt;
  String? pushedAt;
  String? gitUrl;
  String? sshUrl;
  String? cloneUrl;
  String? svnUrl;

  UserRepoModel({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.htmlUrl,
    this.description,
    this.fork,
    this.releasesUrl,
    this.deploymentsUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
  });

  UserRepoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    fullName = json['full_name'];
    private = json['private'];
    htmlUrl = json['html_url'];
    description = json['description'];
    fork = json['fork'];
    releasesUrl = json['releases_url'];
    deploymentsUrl = json['deployments_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pushedAt = json['pushed_at'];
    gitUrl = json['git_url'];
    sshUrl = json['ssh_url'];
    cloneUrl = json['clone_url'];
    svnUrl = json['svn_url'];
  }

  get reposUrl => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['full_name'] = fullName;
    data['private'] = private;
    data['html_url'] = htmlUrl;
    data['description'] = description;
    data['fork'] = fork;
    data['releases_url'] = releasesUrl;
    data['deployments_url'] = deploymentsUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pushed_at'] = pushedAt;
    data['git_url'] = gitUrl;
    data['ssh_url'] = sshUrl;
    data['clone_url'] = cloneUrl;
    data['svn_url'] = svnUrl;
    return data;
  }
}
