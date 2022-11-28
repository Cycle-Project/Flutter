part of '../profile_page.dart';

class _ActionWidget extends StatelessWidget {
  const _ActionWidget({
    Key? key,
    required this.onTap,
    required this.name,
    required this.prefixIcon,
    required this.list,
  }) : super(key: key);

  final Function() onTap;
  final String name;
  final Icon prefixIcon;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 6),
      child: InkWell(
        onTap: onTap,
        child: SpecialCard(
          backgroundColor: Colors.white,
          shadowColor: bluishGrey.withOpacity(.6),
          borderRadius: BorderRadius.circular(6),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: prefixIcon,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (list.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Text(
                      "No $name",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              if (list.isNotEmpty) ...[
                const Divider(height: 0, thickness: 2),
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      list.first,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const Divider(height: 0, thickness: 2),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _SubList(title: name, list: list),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Show All $name",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.keyboard_arrow_right, size: 32),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SubList extends StatelessWidget {
  const _SubList({
    Key? key,
    required this.title,
    required this.list,
  }) : super(key: key);

  final String title;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) => Text(
          list[i],
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
