plan_timezones = input("plan_timezones")
plan_name = input("plan_name", value: "core/tzdata")
base_dir = input("base_dir", value: "include")

hab_pkg_path = command("hab pkg path #{plan_name}")
describe hab_pkg_path do
  its('exit_status') { should eq 0 }
  its('stdout') { should_not be_empty }
end

target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

plan_timezones.each do | plan_timezone |
  describe command("ls -al #{File.join(target_dir, plan_timezone)}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
