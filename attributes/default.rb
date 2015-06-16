node.default[:packer][:url_base] = "https://dl.bintray.com/mitchellh/packer"
node.default[:packer][:version] = "0.6.1"
node.default[:packer][:arch] = kernel['machine'] =~ /x86_64/ ? "amd64" : "386"

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/packer/${VERSION}_SHA256SUMS?direct
node.default[:packer][:raw_checksums] = <<-EOF
    72d57fe6a6ec2660dda2aed73198a4c4d9152037831d6aa44c64a28307c299c7  packer_0.7.5_darwin_386.zip
    c0e149c4515fe548c1daeafabec3b4a091f2aa0c6936723382b3f6fe5a617880  packer_0.7.5_darwin_amd64.zip
    6bce28c51a1862cbc3071421546620fb27007732f7a8470054e7267ca3521b95  packer_0.7.5_freebsd_386.zip
    508293b60f525c44560ca569db5b63b6f92294f655c61b076243a98a0ea75604  packer_0.7.5_freebsd_amd64.zip
    1cef5f1875a19b9c46daca5f36739bf2e9c9d68b1f27319abdc36c02837ac662  packer_0.7.5_freebsd_arm.zip
    6a6ee79d51909f04f734c15a0e12ebcaba3f2cf4d449906f6a186490774262f9  packer_0.7.5_linux_386.zip
    8fab291c8cc988bd0004195677924ab6846aee5800b6c8696d71d33456701ef6  packer_0.7.5_linux_amd64.zip
    8a7d63f0a9282f7b0a833a8455d37f5916d5a9200c17c83627922e08ed9ec2ca  packer_0.7.5_linux_arm.zip
    986d3b038f54ef86de313b10d45248c78159ebf5850615ab326d6e57229086a6  packer_0.7.5_openbsd_386.zip
    c11a67715de000de6742ebe7fb7187ba1db08333ec3941111a72672f0eb27509  packer_0.7.5_openbsd_amd64.zip
    99b879f491df08fa217193edea0b777341c73d4a145f2329b5c795d821258536  packer_0.7.5_windows_386.zip
    1dccdb825bbdd3487747771f58cecb5cbd0a73d44b52958f0d09ac9086b861b9  packer_0.7.5_windows_amd64.zip
    f941d12e5db1dc49665a9b62299df9f97b9dcb4b5dbabbbdf77211e46935aea5  0.6.1_darwin_386.zip
    1ab1cf76be8ab1b953f0e634c96f8a09a9d17eb3d180b120b9d19afff2a94cb4  0.6.1_darwin_amd64.zip
    b1b1d4e34494cbc3da5f3770770201b96426f79db196f415bcfefe0c53ef6ace  0.6.1_freebsd_386.zip
    21ea9231623f156ff1600d60ea024c688a8c526f4cfb62e070e2f158153391e6  0.6.1_freebsd_amd64.zip
    341d9790aa4183085fdea4f5e1998160a3cfbce390a46bc02259d1cfcf95df40  0.6.1_freebsd_arm.zip
    8b83a1c4585335699a675f2bafa004e6da7f46394cd18b1b0218ca9105d4e64f  0.6.1_linux_386.zip
    9c13a55ab7db13509c8556f5d416ef373641da072f54686e7689c18a25b85aea  0.6.1_linux_amd64.zip
    1782d7c3fbbf9376e8fcd22f47247d8a6e9a4099599d4d8c3a8160346c0ee04b  0.6.1_linux_arm.zip
    c32954282f3a249682b0322f89b9a0919793fc445bc7f8d53ad816d46b057b00  0.6.1_openbsd_386.zip
    0d468b1f3244394b2615f78a1a47f61c77110465fa5c270899f32e6387a680e8  0.6.1_openbsd_amd64.zip
    b50e11e0f37efa94de0eeb4d10e1add050d4bee87773dea60faab15da38122f8  0.6.1_windows_386.zip
    1083c4232d6a3a50858b31e99e7e963c799ca9c6c5dd9f0621472c1cb9a33821  0.6.1_windows_amd64.zip
EOF
node.default[:packer][:checksums] = Hash[
    node[:packer][:raw_checksums].split("\n").collect { |s| s.split.reverse }
]

case node[:packer][:version]
    when /^0.7.*$/
        node.default[:packer][:filename] = "packer_#{node[:packer][:version]}_#{node[:os]}_#{node[:packer][:arch]}.zip"
    else
        node.default[:packer][:filename] = "#{node[:packer][:version]}_#{node[:os]}_#{node[:packer][:arch]}.zip"
end

node.default[:packer][:checksum] = node[:packer][:checksums][node[:packer][:filename]]
