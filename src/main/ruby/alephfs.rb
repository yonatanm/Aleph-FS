require "rfuse_ng"

class AlephFS < RFuse::Fuse
  def initialize(mnt,kernelopt,libopt,root)
    super(mnt,kernelopt,libopt)
    @root=root
    puts "I am here"
  end
  
end


fo = AlephFS.new("/tmp/fuse",["allow_other"],["debug"], nil);
#kernel:  default_permissions,allow_other,kernel_cache,large_read,direct_io
#         max_read=N,fsname=NAME
#library: debug,hard_remove

Signal.trap("TERM") do
  fo.exit
  fo.unmount
end

begin
  fo.loop
rescue
  print "Error:" + $!
end